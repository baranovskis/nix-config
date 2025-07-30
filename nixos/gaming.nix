{ pkgs, username, ... }:
{
  # Enable Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  # Gaming packages
  environment.systemPackages = with pkgs; [
    # Game launchers
    lutris
    heroic
    bottles
    
    # Performance tools
    gamemode
    
    # Wine for Windows games
    wineWowPackages.staging
    winetricks
  ];

  # Enable GameMode for performance optimization
  programs.gamemode.enable = true;

  users.users.${username} = {
    extraGroups = [ "gamemode" ];
  };
}
