# User config applicable only to nixos
{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  users.users.baranovskis = {
    isNormalUser = true;
    description = "Andrejs Baranovskis";
    extraGroups = lib.flatten [
      "wheel"
      (ifTheyExist [
        "adbusers"
        "audio"
        "docker"
        "gamemode"
        "git"
        "libvirtd"
        "networkmanager"
        "video"
      ])
    ];
  };
}
