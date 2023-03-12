{ config, pkgs, lib, ... }:
{
  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;
  # users.users.trdthg.extraGroups = [ "docker" ];

}
