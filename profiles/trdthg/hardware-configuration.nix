# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  # Activate kernel modules (choose from built-ins and extra ones)
  boot.kernelModules = [
    "kvm-amd"
    # Virtual Camera
    "v4l2loopback"
    # Virtual Microphone, built-in
    # "snd-aloop"

    # "kvm-intel"
    "hid-nintendo"
  ];
  # Make some extra kernel modules available to NixOS
  boot.extraModulePackages = with config.boot.kernelPackages;
    [ v4l2loopback ];

  # Set initial kernel module settings
  boot.extraModprobeConfig = ''
    # exclusive_caps: Skype, Zoom, Teams etc. will only show device when actually streaming
    # card_label: Name of virtual camera, how it'll show up in Skype, Zoom, Teams
    # https://github.com/umlaeute/v4l2loopback
    options v4l2loopback exclusive_caps=1 card_label="Virtual Camera"

    # KVM libvirtd
    # options kvm_intel nested=1
    # options kvm_intel emulate_invalid_guest_state=0
    # options kvm ignore_msrs=1
  '';

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/9edeed1c-81fb-428b-8402-4cdbf64bd846";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/C561-B48E";
      fsType = "vfat";
    };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/0ac261b7-3ef5-4d88-b2bf-abbd379a7528"; }];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp1s0.useDHCP = lib.mkDefault true;

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
