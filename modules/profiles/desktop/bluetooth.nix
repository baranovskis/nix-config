{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.profiles.desktop.enable {
    hardware.bluetooth = {
      enable = true;
      package = pkgs.bluez-experimental;
      powerOnBoot = true;
      settings = {
        LE = {
          MinConnectionInterval = 16;
          MaxConnectionInterval = 16;
          ConnectionLatency = 10;
          ConnectionSupervisionTimeout = 100;
        };
        Policy.AutoEnable = "true";
        General = {
          FastConnectable = true;
          JustWorksRepairing = "always";
          Experimental = true;
        };
      };
    };

    boot.extraModprobeConfig = ''
      options bluetooth enable_ecred=1
      options bluetooth enable_iso=1
    '';
  };
}
