{ config, lib, pkgs, ... }:
{
  # System-wide power management configuration

  powerManagement = {
    enable = true;
  };

  # Configure systemd-logind power management
  services.logind.settings = {
    Login = {
      HandleLidSwitch = "suspend";
      HandleLidSwitchDocked = "ignore";
      HandleLidSwitchExternalPower = "suspend";

      # Fix for system going back to sleep immediately after wake
      # Increase the inhibitor timeout to allow GNOME to fully wake up
      # Default is 5 seconds which is too short for GNOME to handle resume
      InhibitDelayMaxSec = 60;
    };
  };
}
