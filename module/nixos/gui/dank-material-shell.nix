{
  inputs,
  vars,
  pkgs,
  ...
}: let
  inherit (vars) username;
in {
  programs.gpu-screen-recorder.enable = true;

  home-manager.users.${username} = {
    imports = [
      inputs.dankMaterialShell.homeModules.dank-material-shell
      inputs.dms-plugin-registry.nixosModules.default
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
      plugins = {
        commandRunner.enable = true;
        screenCaptureToolbar.enable = true;
      };
    };

    qt = {
      enable = true;
      platformTheme.name = "qtct";
    };

    systemd.user.sessionVariables.QT_QPA_PLATFORMTHEME_QT6 = "qt6ct";

    home.packages = with pkgs; [slurp jq satty];
  };
}
