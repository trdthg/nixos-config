{ config, pkgs, lib, ... }:
{
  # users.users.trdthg.extraGroups = [ "docker" ];
  users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];
  virtualisation = {
    libvirtd.enable = true;
    docker = {
      enable = true;
    };
    virtualbox = {
      host.enable = true;
    };
    podman = {
      enable = false;
      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = false;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
      # For Nixos version > 22.11
      #defaultNetwork.settings = {
      #  dns_enabled = true;
      #};
    };
  };
}
