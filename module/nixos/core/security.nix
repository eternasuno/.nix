{pkgs, ...}: {
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
      login.enableGnomeKeyring = true;
    };
  };

  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;
  services.dbus.packages = with pkgs; [gcr_3 accountsservice];
  systemd.packages = [pkgs.accountsservice];
  environment.systemPackages = with pkgs; [libsecret];
}
