{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "trdthg";
    userEmail = "trdthg47@gmail.com";
    aliases = {
      ci = "commit";
      co = "checkout";
      s = "status";
      p = "push";
    };
    extraConfig = {
      # credential.helper = "${
      #     pkgs.git.override { withLibsecret = true; }
      #   }/bin/git-credential-libsecret";
      http = {
        proxy = http://127.0.0.1:7890;
        # sslverify = false
      };
      https = {
        proxy = http://127.0.0.1:7890;
      };
    };
  };
}
