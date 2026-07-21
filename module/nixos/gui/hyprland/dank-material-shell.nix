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
    ];

    home.sessionVariables = {
      QT_QPA_PLATFORMTHEME = "qt5ct";
      QS_ICON_THEME = "breeze";
    };

    home.packages = with pkgs; [kdePackages.breeze-icons];

    programs.dank-material-shell = {
      enable = true;
      package = pkgs.dms-shell;
      quickshell.package = pkgs.quickshell;
      enableCalendarEvents = false;
      systemd = {
        enable = true;
        restartIfChanged = true;
      };
    };

    xdg.configFile = {
      "hypr/dms/colors.lua".text = "";
      "hypr/dms/layout.lua".text = "";
      "hypr/dms/outputs.lua".text = "";
    };

    wayland.windowManager.hyprland.extraConfig = ''
      require("dms.colors")
      require("dms.layout")
      require("dms.outputs")

      hl.env("QT_QPA_PLATFORM", "wayland")
      hl.env("QT_QPA_PLATFORMTHEME", "gtk3")
      hl.env("QT_QPA_PLATFORMTHEME_QT6", "gtk3")
      hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

      hl.layer_rule({ match = { namespace = "dms" }, no_anim = true })
    '';
  };
}
