{ lib, ... }: {
  programs.ssh.startAgent = true;

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      AllowUsers = null;
      PasswordAuthentication = lib.mkDefault false;
      PermitRootLogin = lib.mkDefault "no";
      KbdInteractiveAuthentication = false;
      StreamLocalBindUnlink = "yes";
      GatewayPorts = "clientspecified";
    };
  };

  networking.firewall.allowedTCPPorts = [ 22 ];
}
