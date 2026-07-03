{pkgs, ...}: {
  environment.systemPackages = [pkgs.mas];

  homebrew = {
    masApps = {
      "Tampermonkey" = 6738342400;
      "Vimlike" = 1584519802;
      "uBlock Origin Lite" = 6745342698;
    };
  };
}
