{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    maven
    # this doesn't automatically add JAVA_HOME to the environment
    # latest jdk for vscode java lsp, jdk17 on write,
    jdk
  ];

  # this will add JAVA_HOME to the environment
  programs.java = {
    enable = true;
    # jdk8 for projects
    package = pkgs.jdk8;
  };
}
