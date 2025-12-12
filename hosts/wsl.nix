{ config, pkgs, lib, ... }:

let
  username = "erebor"; # byt ut mot din Linux-användare (t.ex. "vinberg")
  homedir = "/home/${username}";
in
{
  # WSL / host-level options
  networking.hostName = "hosts";
  wsl.defaultUser = username;

  home.username = username;
  home.homeDirectory = homedir;

  programs.zsh = {
    enable = true;
    ohMyZsh.enable = true;
  };

  programs.git = {
    enable = true;
    userName = "Your Name";
    userEmail = "you@example.com";
  };

  programs.ssh-agent.enable = true;

  home.packages = with pkgs; [ vim git curl fd ripgrep starship neovim zsh ];

  # Simple WSL-friendly environment tweaks
  home.sessionVariables = {
    # Make GUI apps work with a Windows X server (adjust as needed)
    DISPLAY = lib.mkDefault ('"$(/bin/sh -c "grep -m1 nameserver /etc/resolv.conf | awk '{print $2}'" ):0););
  };

  home.file.".bashrc" = {
    text = ''
# WSL convenience
export PATH="$HOME/.nix-profile/bin:$PATH"
# Use Windows Explorer from WSL
alias explorer='cmd.exe /C start .'
'';
  };

  home.file.".profile".text = ''
# Source Home Manager generated shell profiles
if [ -e "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
  source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
fi
'';

  # Simple starship config
  xdg.configFile."starship.toml".text = ''
add_newline = false
'';
}
