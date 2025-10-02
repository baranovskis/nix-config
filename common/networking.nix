{
  pkgs,
  lib,
  config,
  username,
  ...
}:
{
  networking = {
    # hostname is defined per-host in hosts/*/default.nix
    networkmanager = {
      enable = true;
      wifi.powersave = true;
    };
    dhcpcd.enable = false;
    useDHCP = lib.mkDefault true;
    useHostResolvConf = false;
    usePredictableInterfaceNames = true;
  };

  users.users.${username} = {
    extraGroups = [ "networkmanager" ];
  };
}
