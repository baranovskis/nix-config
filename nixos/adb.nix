{ pkgs, config, ... }:
{
  # Android Debug Bridge
  programs.adb.enable = true;
  users.users.baranovskis.extraGroups = [ "adbusers" ];
}
