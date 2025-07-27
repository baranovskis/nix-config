{ 
  pkgs, 
  config,
  username,
  ... }:
{
  # Android Debug Bridge
  programs.adb.enable = true;
  users.users.${username}.extraGroups = [ "adbusers" ];
}
