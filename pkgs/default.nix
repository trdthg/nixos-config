{ config, pkgs, ... }:
{
  imports = [
    ./python.nix
    ./java.nix
    ./docker.nix
    ./sway.nix
    ./tmp.nix
  ];


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    unzip
    pulseaudioFull

    texlive.combined.scheme-full

    bottom

    #
    # add ranger file icon support
    #
    # git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons
    # echo "default_linemode devicons" >> $HOME/.config/ranger/rc.conf
    ranger

    # kitty can preview images in ranger
    # remember to write `set preview_images_method kitty` in ~/.config/ranger/rc.conf
    kitty

    # a img viwer
    swayimg
  ];
}
