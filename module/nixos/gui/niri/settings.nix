{
  pkgs,
  inputs,
  vars,
  ...
}: let
  inherit (vars) username;
in {
  home-manager.users.${username} = {
    imports = [
      inputs.niri.homeModules.niri
    ];

    programs.niri = {
      enable = true;
      package = pkgs.niri;
      settings = {
        input = {
          touchpad = {
            natural-scroll = false;
            dwt = true;
            accel-speed = 0.15;
            scroll-factor = 1.5;
            accel-profile = "adaptive";
          };
          mouse.natural-scroll = false;
        };
        hotkey-overlay.skip-at-startup = true;
        prefer-no-csd = true;
        layout = {
          gaps = 8;
          background-color = "transparent";
          default-column-width = {proportion = 0.6;};
          preset-column-widths = [
            {proportion = 0.4;}
            {proportion = 0.6;}
            {proportion = 1.0;}
          ];
        };
      };
    };
  };
}
