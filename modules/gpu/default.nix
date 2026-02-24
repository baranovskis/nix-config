{
  config,
  lib,
  pkgs,
  username,
  ...
}:
{
  # Enable OpenGL and Vulkan support
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
}
