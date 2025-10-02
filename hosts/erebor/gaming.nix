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

    # Game launchers
    lutris
    heroic
    bottles
  ];

  users.users.${username} = {
    extraGroups = [ "gamemode" ];
  };
}
