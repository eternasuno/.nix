{
  inputs,
  vars,
  pkgs,
  ...
}: let
  inherit (vars) username;
in {
  home-manager.users.${username} = {
    imports = [
      inputs.dankMaterialShell.homeModules.dank-material-shell
      inputs.dankMaterialShell.homeModules.niri
    ];

    programs.dank-material-shell = {
      enable = true;
      package = pkgs.dms-shell;
      quickshell.package = pkgs.quickshell;
      enableCalendarEvents = false;
      systemd = {
        enable = true;
        restartIfChanged = true;
      };
      niri = {
        includes = {
          enable = true;
          override = true;
          originalFileName = "hm";
          filesToInclude = [
            "alttab"
            "binds"
            "colors"
            "cursor"
            "layout"
            "outputs"
            "windowrules"
            "wpblur"
          ];
        };
      };
    };
  };
}
