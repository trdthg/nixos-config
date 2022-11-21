{ config, pkgs, lib, ... }:
{
  virtualisation.docker.enable = true;
  # users.users.trdthg.extraGroups = [ "docker" ];

}
