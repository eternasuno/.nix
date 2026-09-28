{
  vars,
  pkgs,
  ...
}: let
  inherit (vars) username;
in {
  home-manager.users.${username} = {
    xdg.mimeApps.defaultApplications = {
      "inode/directory" = ["yazi.desktop"];
    };

    xdg.desktopEntries.yazi = {
      name = "Yazi";
      genericName = "File Manager";
      comment = "Blazing fast terminal file manager";
      icon = "yazi";
      exec = "${pkgs.kitty}/bin/kitty yazi %U";
      terminal = false;
      categories = ["System" "FileManager" "FileTools" "ConsoleOnly"];
      mimeType = ["inode/directory"];
    };
  };
}
