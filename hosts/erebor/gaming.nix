{ pkgs, username, ... }:
{
  # Gaming configuration for erebor
  # System services and user applications combined

  # System-level gaming services
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  programs.gamemode.enable = true;

  # System-level gaming packages
  environment.systemPackages = with pkgs; [
    # Performance tools
    gamemode

    # Wine for Windows games
    wineWowPackages.staging
    winetricks

    # Game launchers
    lutris
    heroic
    bottles

    # VFIO & GPU Passthrough
    looking-glass-client
  ];

  users.users.${username} = {
    extraGroups = [ "gamemode" ];
  };
}
