{
  lib,
  username,
  ...
}: {
  networking = {
    networkmanager = {
      enable = true;
      wifi.powersave = true;
    };
    dhcpcd.enable = false;
    useDHCP = lib.mkDefault true;
    useHostResolvConf = false;
    usePredictableInterfaceNames = true;
  };

  users.users.${username}.extraGroups = [ "networkmanager" ];
}
