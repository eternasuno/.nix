{pkgs, ...}: {
  security = {
    polkit.enable = true;
    rtkit.enable = true;
    pam.services = {
      greetd.fprintAuth = true;
      greetd.enableGnomeKeyring = true;
      sudo.fprintAuth = true;
      login.fprintAuth = true;
      login.enableGnomeKeyring = true;
    };
  };

  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;
  services.dbus.packages = with pkgs; [gcr accountsservice];
  systemd.packages = [pkgs.accountsservice];
  environment.systemPackages = with pkgs; [libsecret];
}
