{vars, ...}: let
  inherit (vars) username;
in {
  home-manager.users.${username} = {config, ...}: {
    programs.niri.settings.binds = with config.lib.niri.actions; {
      "Mod+Q".action = close-window;
      "Mod+F".action = maximize-column;
      "Mod+Shift+F".action = fullscreen-window;
      "Mod+V".action = toggle-window-floating;
      "Mod+Shift+V".action = switch-focus-between-floating-and-tiling;

      "Mod+T".action = spawn config.home.sessionVariables.TERMINAL;
      "Mod+B".action = spawn config.home.sessionVariables.BROWSER;
      "Mod+Space" = {
        action = spawn ["dms" "ipc" "call" "spotlight" "toggle"];
        hotkey-overlay.title = "Toggle Application Launcher";
      };

      "Mod+Left".action = focus-column-left;
      "Mod+Right".action = focus-column-right;
      "Mod+H".action = focus-column-left;
      "Mod+L".action = focus-column-right;
      "Mod+U".action = focus-window-down;
      "Mod+I".action = focus-window-up;
      "Mod+Up".action = focus-workspace-up;
      "Mod+Down".action = focus-workspace-down;
      "Mod+K".action = focus-workspace-up;
      "Mod+J".action = focus-workspace-down;

      "Mod+Ctrl+Left".action = move-column-left;
      "Mod+Ctrl+Right".action = move-column-right;
      "Mod+Ctrl+H".action = move-column-left;
      "Mod+Ctrl+L".action = move-column-right;
      "Mod+Ctrl+U".action = move-window-down;
      "Mod+Ctrl+I".action = move-window-up;
      "Mod+Ctrl+Up".action = move-column-to-workspace-up;
      "Mod+Ctrl+Down".action = move-column-to-workspace-down;
      "Mod+Ctrl+K".action = move-column-to-workspace-up;
      "Mod+Ctrl+J".action = move-column-to-workspace-down;

      "Mod+1".action = focus-workspace 1;
      "Mod+2".action = focus-workspace 2;
      "Mod+3".action = focus-workspace 3;
      "Mod+4".action = focus-workspace 4;
      "Mod+5".action = focus-workspace 5;
      "Mod+6".action = focus-workspace 6;
      "Mod+7".action = focus-workspace 7;
      "Mod+8".action = focus-workspace 8;
      "Mod+9".action = focus-workspace 9;

      "Mod+R".action = switch-preset-column-width;
      "Mod+Shift+R".action = switch-preset-window-height;
      "Mod+Shift+Left".action = set-window-width "-10%";
      "Mod+Shift+Right".action = set-window-width "+10%";
      "Mod+Shift+H".action = set-window-width "-10%";
      "Mod+Shift+L".action = set-window-width "+10%";
      "Mod+Shift+Up".action = set-window-height "-10%";
      "Mod+Shift+Down".action = set-window-height "+10%";
      "Mod+Shift+J".action = set-window-height "+10%";
      "Mod+Shift+K".action = set-window-height "-10%";

      "Print".action = spawn ["dms" "ipc" "call" "niri" "screenshot"];
      "Ctrl+Print".action = spawn ["dms" "ipc" "call" "niri" "screenshotScreen"];
      "Alt+Print".action = spawn ["dms" "ipc" "call" "niri" "screenshotWindow"];

      "Mod+N" = {
        action = spawn ["dms" "ipc" "call" "notifications" "toggle"];
        hotkey-overlay.title = "Toggle Notification Center";
      };
      "Mod+P" = {
        action = spawn ["dms" "ipc" "call" "notepad" "toggle"];
        hotkey-overlay.title = "Toggle Notepad";
      };
      "XF86AudioMedia" = {
        action = spawn ["dms" "ipc" "call" "settings" "toggle"];
        hotkey-overlay.title = "Toggle Settings";
      };
      "Mod+C" = {
        action = spawn ["dms" "ipc" "call" "clipboard" "toggle"];
        hotkey-overlay.title = "Toggle Clipboard Manager";
      };
      "Mod+M" = {
        action = spawn ["dms" "ipc" "call" "processlist" "toggle"];
        hotkey-overlay.title = "Toggle Process List";
      };
      "Mod+X" = {
        action = spawn ["dms" "ipc" "call" "powermenu" "toggle"];
        hotkey-overlay.title = "Toggle Power Menu";
      };
      "Mod+Alt+N" = {
        allow-when-locked = true;
        action = spawn ["dms" "ipc" "call" "night" "toggle"];
        hotkey-overlay.title = "Toggle Night Mode";
      };
      "Super+Alt+L" = {
        action = spawn ["dms" "ipc" "call" "lock" "lock"];
        hotkey-overlay.title = "Toggle Lock Screen";
      };

      "XF86AudioRaiseVolume" = {
        allow-when-locked = true;
        action = spawn ["dms" "ipc" "call" "audio" "increment" "3"];
      };
      "XF86AudioLowerVolume" = {
        allow-when-locked = true;
        action = spawn ["dms" "ipc" "call" "audio" "decrement" "3"];
      };
      "XF86AudioMute" = {
        allow-when-locked = true;
        action = spawn ["dms" "ipc" "call" "audio" "mute"];
      };
      "XF86AudioMicMute" = {
        allow-when-locked = true;
        action = spawn ["dms" "ipc" "call" "audio" "micmute"];
      };
      "XF86AudioPlay" = {
        allow-when-locked = true;
        action = spawn ["dms" "ipc" "call" "mpris" "playPause"];
      };
      "XF86AudioPrev" = {
        allow-when-locked = true;
        action = spawn ["dms" "ipc" "call" "mpris" "previous"];
      };
      "XF86AudioNext" = {
        allow-when-locked = true;
        action = spawn ["dms" "ipc" "call" "mpris" "next"];
      };

      "XF86MonBrightnessUp" = {
        allow-when-locked = true;
        action = spawn ["dms" "ipc" "call" "brightness" "increment" "5" ""];
      };
      "XF86MonBrightnessDown" = {
        allow-when-locked = true;
        action = spawn ["dms" "ipc" "call" "brightness" "decrement" "5" ""];
      };
    };
  };
}
