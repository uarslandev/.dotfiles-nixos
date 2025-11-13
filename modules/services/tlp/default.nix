{ config, pkgs, ... }:
let
  hibernateEnvironment = {
    HIBERNATE_SECONDS = "10";
    HIBERNATE_LOCK = "/var/run/autohibernate.lock";
  };
in {
  services.power-profiles-daemon.enable = true;

  systemd.services."awake-after-suspend-for-a-time" = {
    description = "Sets up the suspend so that it'll wake for hibernation only if not on AC power";
    wantedBy = [ "suspend.target" ];
    before = [ "systemd-suspend.service" ];
    environment = hibernateEnvironment;
    script = ''
      if [ $(cat /sys/class/power_supply/AC/online) -eq 0 ]; then
      curtime=$(date +%s)
      echo "$curtime $1" >> /tmp/autohibernate.log
      echo "$curtime" > $HIBERNATE_LOCK
      ${pkgs.utillinux}/bin/rtcwake -m no -s $HIBERNATE_SECONDS
      else
      echo "System is on AC power, skipping wake-up scheduling for hibernation." >> /tmp/autohibernate.log
      fi
      '';
    serviceConfig.Type = "simple";
  };

  systemd.services."hibernate-after-recovery" = {
    description = "Hibernates after a suspend recovery due to timeout";
    wantedBy = [ "suspend.target" ];
    after = [ "systemd-suspend.service" ];
    environment = hibernateEnvironment;
    script = ''
      curtime=$(date +%s)
      sustime=$(cat $HIBERNATE_LOCK)
      rm $HIBERNATE_LOCK
      if [ $(($curtime - $sustime)) -ge $HIBERNATE_SECONDS ] ; then
      systemctl hibernate
      else
      ${pkgs.utillinux}/bin/rtcwake -m no -s 1
      fi
      '';
    serviceConfig.Type = "simple";
  };

  services.logind.settings.Login = {
    HandleLidSwitch = "suspend-then-hibernate";
    HandleLidSwitchExternalPower = "lock";
    HandlePowerKey = "suspend-then-hibernate";
    IdleAction = "suspend-then-hibernate";
    IdleActionSec = "10";
  };

  # Kernel sleep configuration: use deep sleep for suspend
  boot.kernelParams = [ "mem_sleep_default=deep" ];

  # Systemd sleep config for hybrid mode
  systemd.sleep.extraConfig = ''
    AllowSuspendThenHibernate=yes
    SuspendMode=suspend
    HibernateMode=hibernate
    SuspendThenHibernateDelay=10  # Seconds before hibernate after suspend (adjust as needed)
  '';

  services.tlp = {
    enable = false;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 20;

      HANDLE_LID_SWITCH = 0;
      HANDLE_LID_SWITCH_AC = 0;
      HANDLE_LID_SWITCH_DOCKED = 0;

      #Optional helps save long term battery health
      START_CHARGE_THRESH_BAT0 = 40; # 40 and below it starts to charge
      STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging

    };
  };
}
