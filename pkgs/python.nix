{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # python-with-my-packages
    python310
  ];
}
