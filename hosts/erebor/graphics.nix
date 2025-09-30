{
  config,
  lib,
  pkgs,
  username,
  ...
}:
{
  # GPU drivers configuration
  services.xserver.videoDrivers = [ "nvidia" "amdgpu" ];

  # Enable OpenGL and Vulkan support
  hardware.graphics = {
    enable = true;
    enable32Bit = true;  # Required for 32-bit games and Wine
  };

  users.users.${username} = {
    extraGroups = [
      "video"
      "render"
    ];
  };
}
