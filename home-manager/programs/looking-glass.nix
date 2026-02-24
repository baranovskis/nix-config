# Looking Glass client configuration (erebor-specific)
# Only erebor has VFIO GPU passthrough — harmless on other hosts
# (just creates an unused config file)
{...}: {
  xdg.configFile."looking-glass/client.ini".text = ''
    [win]
    size=1920x1200
  '';
}
