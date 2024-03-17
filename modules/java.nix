{ config, pkgs, ... }:
{
  # this will add JAVA_HOME to the environment
  programs.java = {
    enable = true;
    # jdk8 for projects
    package = pkgs.jdk17;
  };
}
