{
  vars,
  ...
}: let
  inherit (vars) username;
in {
  home-manager.users.${username} = {
    qt = {
      enable = true;
      platformTheme.name = "qtct";
    };

    systemd.user.sessionVariables = {
      QT_QPA_PLATFORMTHEME_QT6 = "qt6ct";
    };
  };
}