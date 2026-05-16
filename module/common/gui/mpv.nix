{ pkgs, vars, ... }:
let
  inherit (vars) username;
in {
  home-manager.users.${username} = {
    programs.mpv = {
      enable = true;
      config = {
        profile = "gpu-hq";
        vo = "gpu-next";
        gpu-context = "wayland";
        hwdec = "auto-safe";
        "save-position-on-quit" = "yes";
        "keep-open" = "yes";
        "osd-level" = 1;
      };
      bindings = {
        h = "seek -5";
        l = "seek 5";
        j = "seek 30";
        k = "seek -30";
        "Ctrl+j" = "add volume -5";
        "Ctrl+k" = "add volume 5";
        "Alt+j" = "add brightness -10";
        "Alt+k" = "add brightness 10";
        m = "cycle mute";
        "[" = "multiply speed 0.909";
        "]" = "multiply speed 1.1";
        "{" = "multiply speed 0.5";
        "}" = "multiply speed 2.0";
        "gg" = "seek 0 absolute";
        G = "seek 100 absolute-percent";
        Space = "cycle pause";
        d = "frame-step";
        q = "quit";
        "<" = "playlist-prev";
        ">" = "playlist-next";
      };
    };
  };
}
