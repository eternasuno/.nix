{
  pkgs,
  vars,
  ...
}: let
  inherit (vars) username;
in {
  services.fprintd.enable = true;

  security = {
    polkit = {
      enable = true;
      enablePkexecWrapper = true;
    };

    rtkit.enable = true;

    pam.services = {
      greetd.fprintAuth = true;
      polkit-1.fprintAuth = true;
      sudo.fprintAuth = true;
      login.fprintAuth = true;
    };
  };

  services.passSecretService.enable = true;

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-qt;
  };

  home-manager.users.${username} = {
    home.packages = with pkgs; [pass];
  };
}
