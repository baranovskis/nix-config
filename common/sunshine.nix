{
  pkgs,
  username,
  ...
}: {
  # Sunshine game streaming server
  # Web UI: https://localhost:47990
  # Streaming port: 47989

  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;  # Required for Wayland
    openFirewall = true;
  };

  # Ensure user has required permissions
  users.users.${username}.extraGroups = [ "video" "render" "input" ];
}
