# Base graphics — OpenGL and Vulkan support
{
  config,
  lib,
  username,
  ...
}: let
  cfg = config.modules.gpu;
in {
  options.modules.gpu = {
    enable = lib.mkEnableOption "base graphics support (OpenGL, Vulkan, 32-bit)";
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
