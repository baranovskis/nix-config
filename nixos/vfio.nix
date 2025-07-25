{
  ...
}:
{
  boot.kernelParams = [
    # IOMMU settings based on CPU vendor
    "iommu=pt"
    "intel_iommu=on"
    
    # VFIO settings
    "rd.driver.pre=vfio_pci"
    "vfio_pci.disable_vga=1"
    "vfio_pci.ids=10de:11b4,10de:0e0a"
    
    # KVM optimizations
    "kvm.ignore_msrs=1"
    "kvm.report_ignored_msrs=0"
  ];
  boot.kernelModules = [ "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio" ];

  boot.extraModprobeConfig ="options vfio-pci ids=11b4,10de:0e0a";
}