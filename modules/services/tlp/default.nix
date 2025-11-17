{ config, pkgs, ... }:
let

in {

  services.power-profiles-daemon.enable = false;

  services.logind.settings.Login = {
    HandleLidSwitch = "suspend-then-hibernate";
    HandleLidSwitchExternalPower = "lock";
    HandlePowerKey = "suspend-then-hibernate";
    IdleAction = "suspend-then-hibernate";
    IdleActionSec = "10m";
  };

  boot.kernelParams = [ "mem_sleep_default=deep" ];
  powerManagement.enable = true;
  security.protectKernelImage = false;

  systemd.sleep.extraConfig = ''
    HibernateDelaySec=10m
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

#      HANDLE_LID_SWITCH = 0;
#      HANDLE_LID_SWITCH_AC = 0;
#      HANDLE_LID_SWITCH_DOCKED = 0;

      #Optional helps save long term battery health
      START_CHARGE_THRESH_BAT0 = 40; # 40 and below it starts to charge
      STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging

    };
  };
}
