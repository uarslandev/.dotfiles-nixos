{ inputs, ... }:

{
  perSystem = { pkgs, system, ... }: {
    packages.iso = (inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
        ({ pkgs, ... }: {
          boot.supportedFilesystems = [ "zfs" ];
          boot.zfs.forceImportRoot = false;

          environment.systemPackages = with pkgs; [
            git
            gparted
            util-linux
            parted
            efibootmgr
            zfs
            dosfstools

            (writeShellScriptBin "install-system" ''
              set -e

              echo "=========================================="
              echo "  NixOS ZFS Interactive Installer"
              echo "=========================================="

              # 1. Select Target Disk
              echo ""
              echo "Available Disks:"
              lsblk -d -n -o NAME,SIZE,MODEL | grep -v "^loop" | grep -v "^sr"
              echo ""
              read -p "Enter target disk device (e.g. /dev/nvme0n1 or /dev/sda): " TARGET_DISK

              if [[ ! -b "$TARGET_DISK" ]]; then
                echo "Error: Device $TARGET_DISK does not exist."
                exit 1
              fi

              # 2. Select Hostname
              read -p "Enter target hostname [thinkpad]: " HOSTNAME
              HOSTNAME="''${HOSTNAME:-thinkpad}"

              # 3. Dual-boot choice
              echo ""
              echo "Disk Partitioning Mode:"
              echo "  1) Wipe entire disk (Single boot - full drive ZFS + EFI)"
              echo "  2) Dual-boot (Use existing unallocated free space on disk)"
              read -p "Select choice [1/2]: " DUAL_BOOT_CHOICE

              echo ""
              read -p "WARNING: You are about to modify $TARGET_DISK for hostname '$HOSTNAME'. Continue? (y/N): " confirm
              if [[ "$confirm" != [yY] ]]; then
                echo "Aborted."
                exit 1
              fi

              # Determine partition suffix
              if [[ "$TARGET_DISK" =~ nvme || "$TARGET_DISK" =~ mmcblk ]]; then
                PART_PREFIX="''${TARGET_DISK}p"
              else
                PART_PREFIX="$TARGET_DISK"
              fi

              if [[ "$DUAL_BOOT_CHOICE" == "1" ]]; then
                echo "==> Wiping disk and creating fresh GPT layout..."
                parted -s "$TARGET_DISK" mklabel gpt
                parted -s "$TARGET_DISK" mkpart primary fat32 1MiB 1025MiB
                parted -s "$TARGET_DISK" set 1 esp on
                parted -s "$TARGET_DISK" mkpart primary 1025MiB 100%

                partprobe "$TARGET_DISK" || true
                udevadm settle

                BOOT_PART="''${PART_PREFIX}1"
                ZFS_PART="''${PART_PREFIX}2"

                echo "==> Formatting EFI partition..."
                mkfs.fat -F 32 -n BOOT "$BOOT_PART"
              else
                echo "==> Dual boot mode selected."
                echo "Current partition layout for $TARGET_DISK:"
                parted -s "$TARGET_DISK" print

                read -p "Enter EFI partition device (e.g. ''${PART_PREFIX}1): " BOOT_PART
                read -p "Enter starting position for new ZFS partition (e.g. 250GiB or 50%): " START_POS
                read -p "Enter ending position for new ZFS partition (e.g. 100%): " END_POS

                echo "==> Creating partition in free space..."
                parted -s "$TARGET_DISK" mkpart primary "$START_POS" "$END_POS"
                
                partprobe "$TARGET_DISK" || true
                udevadm settle

                LAST_PART_NUM=$(parted -s "$TARGET_DISK" print | awk '/^ [0-9]+/ {print $1}' | tail -n 1)
                ZFS_PART="''${PART_PREFIX}''${LAST_PART_NUM}"
              fi

              echo "==> Creating encrypted ZFS pool (zpool) on $ZFS_PART..."
              zpool create -O encryption=on \
                           -O keyformat=passphrase \
                           -O keylocation=prompt \
                           -O compression=on \
                           -O mountpoint=none \
                           -O xattr=sa \
                           -O acltype=posixacl \
                           -o ashift=12 \
                           zpool "$ZFS_PART"

              echo "==> Creating datasets..."
              zfs create -o mountpoint=legacy zpool/root
              zfs create -o mountpoint=legacy zpool/nix
              zfs create -o mountpoint=legacy zpool/var
              zfs create -o mountpoint=legacy zpool/home

              echo "==> Mounting filesystems under /mnt..."
              mount -t zfs zpool/root /mnt
              mkdir -p /mnt/{nix,var,home,boot}
              mount -t zfs zpool/nix /mnt/nix
              mount -t zfs zpool/var /mnt/var
              mount -t zfs zpool/home /mnt/home
              mount "$BOOT_PART" /mnt/boot

              echo "==> Cloning dotfiles repository..."
              mkdir -p /mnt/home/umut
              git clone "https://github.com/uarslandev/.dotfiles-nixos.git" /mnt/home/umut/.dotfiles

              # Fix boot partition path in hardware config if host module exists
              FOUND_HW=$(find /mnt/home/umut/.dotfiles/modules -type f -path "*/$HOSTNAME/*" -name "*.nix" | head -n 1)
              if [[ -n "$FOUND_HW" ]]; then
                echo "==> Updating boot partition device reference in $FOUND_HW..."
                sed -i "s|device = \"/dev/disk/by-id/.*\";|device = \"$BOOT_PART\";|g" "$FOUND_HW"
              fi

              echo "==> Installing NixOS via Flake..."
              cd /mnt/home/umut/.dotfiles
              nixos-install --flake ".#''${HOSTNAME}" --no-root-passwd

              echo "==> Adjusting ownership for /home/umut..."
              chown -R 1000:100 /mnt/home/umut || true

              echo "=========================================="
              echo "  Installation finished successfully!"
              echo "  You can now run 'reboot'."
              echo "=========================================="
            '')
          ];
        })
      ];
    }).config.system.build.isoImage;
  };
}
