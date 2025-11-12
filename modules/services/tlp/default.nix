{ config, pkgs, ... }:
let
  hibernateEnvironment = {
    HIBERNATE_SECONDS = "3600";
    HIBERNATE_LOCK = "/var/run/autohibernate.lock";
  };
in {
  services.power-profiles-daemon.enable = false;

  systemd.services.systemd-suspend-then-hibernate = {
    serviceConfig = {
      Environment = "SYSTEMD_BYPASS_SUSPEND_THEN_HIBERNATE=0";
      ExecStart = "${config.systemd.package}/lib/systemd/systemd-sleep suspend-then-hibernate";
    };
    environment = {
      HIBERNATE_DELAY_SEC = "10";
          HIBERNATE_SECONDS = "10";
    HIBERNATE_LOCK = "/var/run/autohibernate.lock";

    };
  };


  services.logind = {
    lidSwitch = "suspend-then-hibernate";
    lidSwitchExternalPower = "suspend-then-hibernate";
    lidSwitchDocked = "ignore";
    powerKey = "hibernate";
    powerKeyLongPress = "ignore";
  };

  # Kernel sleep configuration: use deep sleep for suspend
  boot.kernelParams = [ "mem_sleep_default=deep" ];

  # systemd sleep configuration
  systemd.sleep.extraConfig = ''
    HibernateDelaySec=30
    SuspendState=mem
    HibernateState=disk
  '';

  services.tlp = {
    enable = true;
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
