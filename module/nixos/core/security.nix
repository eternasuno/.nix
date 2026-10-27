{...}: {
  services.fprintd.enable = true;

  security = {
    polkit = {
      enable = true;
      enablePkexecWrapper = true;
    };

    rtkit.enable = true;

    pam.services = {
      greetd.enableGnomeKeyring = true;
    };
  };

  services.gnome.gnome-keyring.enable = true;
}
