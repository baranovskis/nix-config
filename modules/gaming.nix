{ pkgs, username, ... }:
{
  # Gaming configuration for erebor
  # System services stay in Nix (need kernel/driver integration)
  # Game launchers live in Flatpak (see common/flatpak.nix)

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

  environment.systemPackages = with pkgs; [
    gamemode
  ];

  users.users.${username} = {
    extraGroups = [ "gamemode" ];
  };
}
