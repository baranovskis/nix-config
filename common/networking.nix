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

    # Firewall configuration
    firewall = {
      enable = true;
      allowedTCPPorts = [ 3389 ]; # RDP
    };
  };

  users.users.${username} = {
    extraGroups = [ "networkmanager" ];
  };
}
