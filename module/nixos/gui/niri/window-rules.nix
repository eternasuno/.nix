{vars, ...}: let
  inherit (vars) username;
in {
  home-manager.users.${username}.programs.niri.settings.window-rules = [
    {
      matches = [
        {
          app-id = "^firefox$";
          title = "^(Picture-in-Picture|画中画)$";
        }
      ];
      open-floating = true;
      default-column-width = {proportion = 0.3;};
      default-window-height = {proportion = 0.3;};
      default-floating-position = {
        x = 10;
        y = 10;
        relative-to = "bottom-right";
      };
    }

    {
      matches = [{app-id = "^firefox$";}];
      excludes = [
        {
          title = "^(Picture-in-Picture|画中画)$";
        }
      ];
      default-column-width = {proportion = 1.0;};
    }

    {
      matches = [{app-id = "^kitty$";}];
      default-column-width = {proportion = 0.6;};
      opacity = 0.9;
    }
  ];
}
