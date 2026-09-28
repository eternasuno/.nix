{
  vars,
  pkgs,
  ...
}: let
  inherit (vars) username;
in {
  services.udisks2.enable = true;

  environment.systemPackages = [
    pkgs.eject
    pkgs.xdg-utils
  ];

  home-manager.users.${username} = {
    services.udiskie = {
      enable = true;
      automount = true;
      notify = true;
      settings.program_options.file_manager = "${pkgs.xdg-utils}/bin/xdg-open";
    };
  };
}
