{ pkgs, username, ... }:
{
  users.users.${username} = {
    description = "Andrejs Baranovskis";
    shell = pkgs.fish;
    isNormalUser = true;
    initialPassword = "P@ssw0rd";
    extraGroups = [
      "wheel"
    ];
  };
}
