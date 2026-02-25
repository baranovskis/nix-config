{ pkgs, username, fullName, ... }: {
  users.users.${username} = {
    description = fullName;
    shell = pkgs.fish;
    isNormalUser = true;
    initialPassword = "P@ssw0rd";
    extraGroups = [ "wheel" ];
  };
}
