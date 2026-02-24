# Gaming — Steam, gamemode, Proton
# Game launchers (Lutris, Heroic, Bottles) live in Flatpak (see common/flatpak.nix)
{
  config,
  lib,
  pkgs,
  username,
  ...
}: let
  cfg = config.modules.gaming;
in {
  options.modules.gaming = {
    enable = lib.mkEnableOption "gaming support (Steam, gamemode, Proton)";
  };

  config = lib.mkIf cfg.enable {
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
      extraGroups = ["gamemode"];
    };
  };
}
