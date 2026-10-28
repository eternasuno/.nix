{...}: {
  qt = {
    enable = true;
    platformTheme = "qt5ct";
  };

  environment.sessionVariables.QT_QPA_PLATFORMTHEME_QT6 = "qt6ct";
}
