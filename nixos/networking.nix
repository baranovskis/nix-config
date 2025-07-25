{
  pkgs,
  lib,
  config,
  ...
}:
{
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    dhcpcd.enable = false;
    useDHCP = lib.mkDefault true;
    useHostResolvConf = false;
    usePredictableInterfaceNames = true;
    enableIPv6 = false;
  };
}
