{
  pkgs,
  vars,
  ...
}: let
  inherit (vars) username;
in {
  home-manager.users.${username} = {
    i18n.inputMethod = {
      type = "fcitx5";
      enable = true;
      fcitx5 = {
        addons = with pkgs.qt6Packages; [
          fcitx5-chinese-addons
        ];
        settings = {
          inputMethod = {
            GroupOrder."0" = "Default";
            "Groups/0" = {
              Name = "Default";
              "Default Layout" = "us";
              DefaultIM = "pinyin";
            };
            "Groups/0/Items/0".Name = "keyboard-us";
            "Groups/0/Items/1".Name = "pinyin";
          };

          addons = {
            classicui.globalSection = {
              "Vertical Candidate List" = true;
            };
          };
        };
        waylandFrontend = true;
      };
    };
  };
}
