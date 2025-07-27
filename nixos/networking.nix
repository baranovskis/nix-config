{
  pkgs,
  lib,
  config,
  username,
  ...
}:
{
  networking = {
    hostName = "nixos";
    networkmanager = {
      enable = true;
      wifi.powersave = true;
    };
    dhcpcd.enable = false;
    useDHCP = lib.mkDefault true;
    useHostResolvConf = false;
    usePredictableInterfaceNames = true;
    enableIPv6 = false;
  };

  users.users.${username} = {
    extraGroups = [ "networkmanager" ];
  };
}
