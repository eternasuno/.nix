{
  inputs,
  vars,
  ...
}: let
  inherit (vars) username;
in {
  home-manager.users.${username} = {
    imports = [
      inputs.dankMaterialShell.homeModules.niri
    ];

    programs.dank-material-shell = {
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
