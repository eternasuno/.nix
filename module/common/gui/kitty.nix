{vars, ...}: let
  inherit (vars) username;
in {
  home-manager.users.${username} = {
    programs.kitty = {
      enable = true;

      settings = {
        font_family = "Maple Mono NL NF CN";
        bold_font = "auto";
        italic_font = "auto";
        bold_italic_font = "auto";
        font_size = 14.0;

        background_opacity = "0.9";
        background_blur = 20;
        window_padding_width = 4;
        hide_window_decorations = "yes";

        scrollback_indicator_opacity = "0.0";

        sync_to_monitor = "yes";

        background = "#282c34";
        foreground = "#abb2bf";
        cursor = "#528bff";
        selection_background = "#3e4452";
        selection_foreground = "#abb2bf";

        color0 = "#282c34";
        color8 = "#545862";
        color1 = "#e06c75";
        color9 = "#e06c75";
        color2 = "#98c379";
        color10 = "#98c379";
        color3 = "#d19a66";
        color11 = "#e5c07b";
        color4 = "#61afef";
        color12 = "#61afef";
        color5 = "#c678dd";
        color13 = "#c678dd";
        color6 = "#56b6c2";
        color14 = "#56b6c2";
        color7 = "#abb2bf";
        color15 = "#ffffff";
      };

      extraConfig = ''
        confirm_os_window_close 0
        cursor_shape underline
        cursor_blink_interval 0.5
      '';
    };
  };
}
