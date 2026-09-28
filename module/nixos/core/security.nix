{...}: {
  services.fprintd.enable = true;

  security = {
    polkit = {
      enable = true;
      enablePkexecWrapper = true;
    };

    rtkit.enable = true;

    pam.services = {
      greetd.fprintAuth = true;
      greetd.enableGnomeKeyring = true;
      polkit-1.fprintAuth = true;
      sudo.fprintAuth = true;
      login.fprintAuth = true;
    };
  };

  services.gnome.gnome-keyring.enable = true;
}
