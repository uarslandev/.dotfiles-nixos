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
            fdisk
            parted
            efibootmgr

            # Automated installer script
            (writeShellScriptBin "install-system" ''
              set -e

              TARGET_DISK="''${1:-/dev/nvme0n1}"
              DOTFILES_REPO="https://github.com/YOUR_GITHUB_USERNAME/YOUR_DOTFILES_REPO.git"
              HOSTNAME="''${2:-nixos}"

              echo "==> Target Disk: $TARGET_DISK"
              echo "==> Hostname: $HOSTNAME"
              read -p "WARNING: All data on $TARGET_DISK will be erased! Continue? (y/N): " confirm
              if [[ "$confirm" != [yY] ]]; then
                echo "Aborted."
                exit 1
              fi

              echo "==> Partitioning disk..."
              parted -s "$TARGET_DISK" mklabel gpt
              parted -s "$TARGET_DISK" mkpart primary fat32 1MiB 1025MiB
              parted -s "$TARGET_DISK" set 1 esp on
              parted -s "$TARGET_DISK" mkpart primary 1025MiB 100%

              BOOT_PART="''${TARGET_DISK}p1"
              ZFS_PART="''${TARGET_DISK}p2"
              if [[ "$TARGET_DISK" =~ ^/dev/sd.* ]]; then
                BOOT_PART="''${TARGET_DISK}1"
                ZFS_PART="''${TARGET_DISK}2"
              fi

              echo "==> Formatting boot partition..."
              mkfs.fat -F 32 -n BOOT "$BOOT_PART"

              echo "==> Creating ZFS pool..."
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

              echo "==> Mounting filesystems..."
              mount -t zfs zpool/root /mnt
              mkdir -p /mnt/{nix,var,home,boot}
              mount -t zfs zpool/nix /mnt/nix
              mount -t zfs zpool/var /mnt/var
              mount -t zfs zpool/home /mnt/home
              mount "$BOOT_PART" /mnt/boot

              echo "==> Cloning dotfiles..."
              git clone "$DOTFILES_REPO" /mnt/etc/nixos

              echo "==> Running nixos-install..."
              cd /mnt/etc/nixos
              nixos-install --flake ".#$HOSTNAME" --no-root-passwd

              echo "==> Installation finished! You can now reboot."
            '')
          ];
        })
      ];
    }).config.system.build.isoImage;
  };
}
