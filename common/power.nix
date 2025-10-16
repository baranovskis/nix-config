{ config, lib, pkgs, ... }:
{
  # System-wide power management configuration
  #
  # This module handles:
  # - Basic power management settings
  # - Wakeup source control (USB/PCIe devices)
  # - Wake-on-LAN configuration

  # Enable power management
  powerManagement = {
    enable = true;
  };

  # Wakeup Configuration
  # -------------------
  # Disable ALL USB and PCIe wakeup triggers.
  # Only power button and RTC (timer) will be able to wake the system.
  #
  # Based on NixOS best practices:
  # - https://discourse.nixos.org/t/stop-mouse-from-waking-up-the-computer/12539
  # - https://nixos.wiki/wiki/Power_Management

  # Disable wakeup for ALL USB and PCIe devices
  services.udev.extraRules = ''
    # Disable all USB device wakeup (prevents mouse/keyboard/any USB device from waking PC)
    ACTION=="add", SUBSYSTEM=="usb", ATTR{power/wakeup}="disabled"

    # Disable all PCIe port wakeup (prevents network cards, GPUs, NVMe, etc. from waking PC)
    ACTION=="add", SUBSYSTEM=="pci", ATTR{power/wakeup}="disabled"
  '';

  # Enable Wake-on-LAN for ethernet interface
  # This allows you to wake the PC remotely via network magic packet
  # Note: You may need to enable WOL in BIOS/UEFI settings as well
  networking.interfaces.eno1.wakeOnLan.enable = true;

  # After this configuration, your PC can wake from:
  # - Power button press (hardware-controlled, cannot be disabled via software)
  # - Wake-on-LAN magic packet on ethernet (eno1)
  # - RTC/timer-based wakeup (scheduled tasks)
  #
  # Your PC will NOT wake from:
  # - USB devices (mouse/keyboard movement)
  # - Other PCIe devices (except network card for WOL)
}
