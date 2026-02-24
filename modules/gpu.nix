{
  config,
  lib,
  username,
  ...
}: let
  cfg = config.modules.gpu;
in {
  options.modules.gpu = {
    enable = lib.mkEnableOption "base graphics support";
  };

  config = lib.mkIf cfg.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    users.users.${username} = {
      extraGroups = [
        "video"
        "render"
      ];
    };
  };
}
