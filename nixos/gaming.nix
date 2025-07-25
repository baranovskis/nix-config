{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
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

  # Enable GameMode for performance optimization
  programs.gamemode.enable = true;

  # Gaming packages
  environment.systemPackages = with pkgs; [
    # Game launchers
    lutris
    heroic
    
    # Performance tools
    gamemode
    
    # Wine for Windows games
    wineWowPackages.staging
    winetricks
  ];
}
