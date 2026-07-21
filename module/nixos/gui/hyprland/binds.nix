{vars, ...}: let
  inherit (vars) username;
in {
  home-manager.users.${username} = {config, ...}: let
    mod = "SUPER";
  in {
    wayland.windowManager.hyprland.extraConfig = ''
      -- Window management
      hl.bind("${mod} + Q", hl.dsp.killactive)
      hl.bind("${mod} + F", hl.dsp.layout("promote"))
      hl.bind("${mod} + SHIFT + F", hl.dsp.fullscreen("layout_aware"))
      hl.bind("${mod} + V", hl.dsp.togglefloating)
      hl.bind("${mod} + SHIFT + V", hl.dsp.togglefloating)

      -- Focus columns (scrolling left/right)
      hl.bind("${mod} + Left", hl.dsp.layout("focus l"))
      hl.bind("${mod} + Right", hl.dsp.layout("focus r"))
      hl.bind("${mod} + H", hl.dsp.layout("focus l"))
      hl.bind("${mod} + L", hl.dsp.layout("focus r"))

      -- Workspace switching
      hl.bind("${mod} + Up", hl.dsp.workspace("+1"))
      hl.bind("${mod} + Down", hl.dsp.workspace("-1"))
      hl.bind("${mod} + K", hl.dsp.workspace("+1"))
      hl.bind("${mod} + J", hl.dsp.workspace("-1"))

      -- Move columns left/right
      hl.bind("${mod} + CTRL + Left", hl.dsp.layout("move -col"))
      hl.bind("${mod} + CTRL + Right", hl.dsp.layout("move +col"))
      hl.bind("${mod} + CTRL + H", hl.dsp.layout("move -col"))
      hl.bind("${mod} + CTRL + L", hl.dsp.layout("move +col"))

      -- Move windows within column (up = above, down = below)
      hl.bind("${mod} + CTRL + U", hl.dsp.layout("movewindowto u"))
      hl.bind("${mod} + CTRL + I", hl.dsp.layout("movewindowto d"))

      -- Move column to workspace
      hl.bind("${mod} + CTRL + Up", hl.dsp.layout("movecoltoworkspace +1"))
      hl.bind("${mod} + CTRL + Down", hl.dsp.layout("movecoltoworkspace -1"))
      hl.bind("${mod} + CTRL + K", hl.dsp.layout("movecoltoworkspace +1"))
      hl.bind("${mod} + CTRL + J", hl.dsp.layout("movecoltoworkspace -1"))

      -- Workspace numbers
      hl.bind("${mod} + 1", hl.dsp.workspace("1"))
      hl.bind("${mod} + 2", hl.dsp.workspace("2"))
      hl.bind("${mod} + 3", hl.dsp.workspace("3"))
      hl.bind("${mod} + 4", hl.dsp.workspace("4"))
      hl.bind("${mod} + 5", hl.dsp.workspace("5"))
      hl.bind("${mod} + 6", hl.dsp.workspace("6"))
      hl.bind("${mod} + 7", hl.dsp.workspace("7"))
      hl.bind("${mod} + 8", hl.dsp.workspace("8"))
      hl.bind("${mod} + 9", hl.dsp.workspace("9"))

      -- Column width cycling and resize
      hl.bind("${mod} + R", hl.dsp.layout("colresize +conf"))
      hl.bind("${mod} + SHIFT + R", hl.dsp.layout("colresize -conf"))
      hl.bind("${mod} + SHIFT + Left", hl.dsp.layout("colresize -0.1"))
      hl.bind("${mod} + SHIFT + Right", hl.dsp.layout("colresize +0.1"))
      hl.bind("${mod} + SHIFT + H", hl.dsp.layout("colresize -0.1"))
      hl.bind("${mod} + SHIFT + L", hl.dsp.layout("colresize +0.1"))

      -- Launch apps
      hl.bind("${mod} + T", hl.dsp.exec("${config.home.sessionVariables.TERMINAL}"))
      hl.bind("${mod} + B", hl.dsp.exec("${config.home.sessionVariables.BROWSER}"))

      -- DMS IPC
      hl.bind("${mod} + SPACE", hl.dsp.exec("dms ipc call spotlight toggle"))
      hl.bind("${mod} + N", hl.dsp.exec("dms ipc call notifications toggle"))
      hl.bind("${mod} + P", hl.dsp.exec("dms ipc call notepad toggle"))
      hl.bind("${mod} + C", hl.dsp.exec("dms ipc call clipboard toggle"))
      hl.bind("${mod} + M", hl.dsp.exec("dms ipc call processlist toggle"))
      hl.bind("${mod} + X", hl.dsp.exec("dms ipc call powermenu toggle"))
      hl.bind("${mod} + Comma", hl.dsp.exec("dms ipc call settings toggle"))
      hl.bind("${mod} + ALT + N", hl.dsp.exec("dms ipc call night toggle"), { locked = true })
      hl.bind("SUPER + ALT + L", hl.dsp.exec("dms ipc call lock lock"))

      -- Screenshots (DMS niri compat)
      hl.bind("Print", hl.dsp.exec("dms ipc call niri screenshot"))
      hl.bind("CTRL + Print", hl.dsp.exec("dms ipc call niri screenshotScreen"))
      hl.bind("ALT + Print", hl.dsp.exec("dms ipc call niri screenshotWindow"))

      -- Media keys
      hl.bind("XF86AudioRaiseVolume", hl.dsp.exec("dms ipc call audio increment 3"), { locked = true, repeating = true })
      hl.bind("XF86AudioLowerVolume", hl.dsp.exec("dms ipc call audio decrement 3"), { locked = true, repeating = true })
      hl.bind("XF86AudioMute", hl.dsp.exec("dms ipc call audio mute"), { locked = true })
      hl.bind("XF86AudioMicMute", hl.dsp.exec("dms ipc call audio micmute"), { locked = true })
      hl.bind("XF86AudioPlay", hl.dsp.exec("dms ipc call mpris playPause"), { locked = true })
      hl.bind("XF86AudioPrev", hl.dsp.exec("dms ipc call mpris previous"), { locked = true })
      hl.bind("XF86AudioNext", hl.dsp.exec("dms ipc call mpris next"), { locked = true })
      hl.bind("XF86MonBrightnessUp", hl.dsp.exec("dms ipc call brightness increment 5"), { locked = true, repeating = true })
      hl.bind("XF86MonBrightnessDown", hl.dsp.exec("dms ipc call brightness decrement 5"), { locked = true, repeating = true })
    '';
  };
}
