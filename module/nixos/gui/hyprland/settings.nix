{
  vars,
  config,
  lib,
  ...
}: let
  inherit (vars) username;
  mkLuaInline = lib.generators.mkLuaInline;
in {
  home-manager.users.${username} = {
    wayland.windowManager.hyprland = {
      enable = true;
      configType = "lua";

      extraConfig = ''
        local home = os.getenv("HOME")
        pcall(dofile, home .. "/.config/hypr/dms/spotlight.lua")
        pcall(dofile, home .. "/.config/hypr/dms/notifications.lua")
        pcall(dofile, home .. "/.config/hypr/dms/notepad.lua")
        pcall(dofile, home .. "/.config/hypr/dms/clipboard.lua")
        pcall(dofile, home .. "/.config/hypr/dms/processlist.lua")
        pcall(dofile, home .. "/.config/hypr/dms/powermenu.lua")
        pcall(dofile, home .. "/.config/hypr/dms/settings.lua")
        pcall(dofile, home .. "/.config/hypr/dms/night.lua")
        pcall(dofile, home .. "/.config/hypr/dms/lock.lua")
        pcall(dofile, home .. "/.config/hypr/dms/audio.lua")
        pcall(dofile, home .. "/.config/hypr/dms/brightness.lua")
        pcall(dofile, home .. "/.config/hypr/dms/screenshot.lua")
      '';

      settings = {
        mod = {
          _var = "SUPER";
        };

        config = {
          general = {
            layout = "scrolling";
            gaps_in = 5;
            gaps_out = 8;
            border_size = 0;
          };

          scrolling = {
            column_width = 0.6;
            fullscreen_on_one_column = false;
            focus_fit_method = 1;
            follow_focus = true;
            follow_min_visible = 0.4;
            explicit_column_widths = "0.4, 0.6, 1.0";
            direction = "right";
            wrap_focus = true;
            wrap_swapcol = true;
          };

          input = {
            touchpad = {
              natural_scroll = false;
              scroll_factor = 1.5;
            };
            natural_scroll = false;
            accel_profile = "adaptive";
            scroll_factor = 1.0;
          };

          misc = {
            disable_hyprland_logo = true;
            disable_splash_rendering = true;
          };

          decoration = {
            rounding = 12;
            inactive_opacity = 0.9;
          };
        };

        bind = [
          {
            _args = [
              (mkLuaInline "mod .. \" + Q\"")
              (mkLuaInline "hl.dsp.window.close()")
            ];
          }
          {
            _args = [
              (mkLuaInline "mod .. \" + F\"")
              (mkLuaInline "hl.dsp.layout(\"promote\")")
            ];
          }
          {
            _args = [
              "SUPER + SHIFT + F"
              (mkLuaInline "hl.dsp.window.fullscreen({})")
            ];
          }
          {
            _args = [
              (mkLuaInline "mod .. \" + V\"")
              (mkLuaInline "hl.dsp.window.float()")
            ];
          }
          {
            _args = [
              "SUPER + SHIFT + V"
              (mkLuaInline "hl.dsp.window.float()")
            ];
          }
          {
            _args = [
              (mkLuaInline "mod .. \" + Left\"")
              (mkLuaInline "hl.dsp.layout(\"focus l\")")
            ];
          }
          {
            _args = [
              (mkLuaInline "mod .. \" + Right\"")
              (mkLuaInline "hl.dsp.layout(\"focus r\")")
            ];
          }
          {
            _args = [
              (mkLuaInline "mod .. \" + H\"")
              (mkLuaInline "hl.dsp.layout(\"focus l\")")
            ];
          }
          {
            _args = [
              (mkLuaInline "mod .. \" + L\"")
              (mkLuaInline "hl.dsp.layout(\"focus r\")")
            ];
          }
          {
            _args = [
              (mkLuaInline "mod .. \" + Up\"")
              (mkLuaInline "hl.dsp.focus({ workspace = \"+1\" })")
            ];
          }
          {
            _args = [
              (mkLuaInline "mod .. \" + Down\"")
              (mkLuaInline "hl.dsp.focus({ workspace = \"-1\" })")
            ];
          }
          {
            _args = [
              (mkLuaInline "mod .. \" + K\"")
              (mkLuaInline "hl.dsp.focus({ workspace = \"+1\" })")
            ];
          }
          {
            _args = [
              (mkLuaInline "mod .. \" + J\"")
              (mkLuaInline "hl.dsp.focus({ workspace = \"-1\" })")
            ];
          }
          {
            _args = [
              "SUPER + CTRL + Left"
              (mkLuaInline "hl.dsp.layout(\"move -col\")")
            ];
          }
          {
            _args = [
              "SUPER + CTRL + Right"
              (mkLuaInline "hl.dsp.layout(\"move +col\")")
            ];
          }
          {
            _args = [
              "SUPER + CTRL + H"
              (mkLuaInline "hl.dsp.layout(\"move -col\")")
            ];
          }
          {
            _args = [
              "SUPER + CTRL + L"
              (mkLuaInline "hl.dsp.layout(\"move +col\")")
            ];
          }
          {
            _args = [
              "SUPER + CTRL + U"
              (mkLuaInline "hl.dsp.window.move({ direction = \"u\" })")
            ];
          }
          {
            _args = [
              "SUPER + CTRL + I"
              (mkLuaInline "hl.dsp.window.move({ direction = \"d\" })")
            ];
          }
          {
            _args = [
              "SUPER + CTRL + Up"
              (mkLuaInline "hl.dsp.window.move({ workspace = \"+1\" })")
            ];
          }
          {
            _args = [
              "SUPER + CTRL + Down"
              (mkLuaInline "hl.dsp.window.move({ workspace = \"-1\" })")
            ];
          }
          {
            _args = [
              "SUPER + CTRL + K"
              (mkLuaInline "hl.dsp.window.move({ workspace = \"+1\" })")
            ];
          }
          {
            _args = [
              "SUPER + CTRL + J"
              (mkLuaInline "hl.dsp.window.move({ workspace = \"-1\" })")
            ];
          }
          {
            _args = [
              (mkLuaInline "mod .. \" + 1\"")
              (mkLuaInline "hl.dsp.focus({ workspace = \"1\" })")
            ];
          }
          {
            _args = [
              (mkLuaInline "mod .. \" + 2\"")
              (mkLuaInline "hl.dsp.focus({ workspace = \"2\" })")
            ];
          }
          {
            _args = [
              (mkLuaInline "mod .. \" + 3\"")
              (mkLuaInline "hl.dsp.focus({ workspace = \"3\" })")
            ];
          }
          {
            _args = [
              (mkLuaInline "mod .. \" + 4\"")
              (mkLuaInline "hl.dsp.focus({ workspace = \"4\" })")
            ];
          }
          {
            _args = [
              (mkLuaInline "mod .. \" + 5\"")
              (mkLuaInline "hl.dsp.focus({ workspace = \"5\" })")
            ];
          }
          {
            _args = [
              (mkLuaInline "mod .. \" + 6\"")
              (mkLuaInline "hl.dsp.focus({ workspace = \"6\" })")
            ];
          }
          {
            _args = [
              (mkLuaInline "mod .. \" + 7\"")
              (mkLuaInline "hl.dsp.focus({ workspace = \"7\" })")
            ];
          }
          {
            _args = [
              (mkLuaInline "mod .. \" + 8\"")
              (mkLuaInline "hl.dsp.focus({ workspace = \"8\" })")
            ];
          }
          {
            _args = [
              (mkLuaInline "mod .. \" + 9\"")
              (mkLuaInline "hl.dsp.focus({ workspace = \"9\" })")
            ];
          }
          {
            _args = [
              (mkLuaInline "mod .. \" + R\"")
              (mkLuaInline "hl.dsp.layout(\"colresize +conf\")")
            ];
          }
          {
            _args = [
              "SUPER + SHIFT + R"
              (mkLuaInline "hl.dsp.layout(\"colresize -conf\")")
            ];
          }
          {
            _args = [
              "SUPER + SHIFT + Left"
              (mkLuaInline "hl.dsp.layout(\"colresize -0.1\")")
            ];
          }
          {
            _args = [
              "SUPER + SHIFT + Right"
              (mkLuaInline "hl.dsp.layout(\"colresize +0.1\")")
            ];
          }
          {
            _args = [
              "SUPER + SHIFT + H"
              (mkLuaInline "hl.dsp.layout(\"colresize -0.1\")")
            ];
          }
          {
            _args = [
              "SUPER + SHIFT + L"
              (mkLuaInline "hl.dsp.layout(\"colresize +0.1\")")
            ];
          }
          {
            _args = [
              (mkLuaInline "mod .. \" + T\"")
              (mkLuaInline "hl.dsp.exec_cmd(\"${config.home.sessionVariables.TERMINAL}\")")
            ];
          }
          {
            _args = [
              (mkLuaInline "mod .. \" + B\"")
              (mkLuaInline "hl.dsp.exec_cmd(\"${config.home.sessionVariables.BROWSER}\")")
            ];
          }
          {
            _args = [
              (mkLuaInline "mod .. \" + SPACE\"")
              (mkLuaInline "hl.dsp.exec_cmd(\"dms ipc call spotlight toggle\")")
            ];
          }
          {
            _args = [
              (mkLuaInline "mod .. \" + N\"")
              (mkLuaInline "hl.dsp.exec_cmd(\"dms ipc call notifications toggle\")")
            ];
          }
          {
            _args = [
              (mkLuaInline "mod .. \" + P\"")
              (mkLuaInline "hl.dsp.exec_cmd(\"dms ipc call notepad toggle\")")
            ];
          }
          {
            _args = [
              (mkLuaInline "mod .. \" + C\"")
              (mkLuaInline "hl.dsp.exec_cmd(\"dms ipc call clipboard toggle\")")
            ];
          }
          {
            _args = [
              (mkLuaInline "mod .. \" + M\"")
              (mkLuaInline "hl.dsp.exec_cmd(\"dms ipc call processlist toggle\")")
            ];
          }
          {
            _args = [
              (mkLuaInline "mod .. \" + X\"")
              (mkLuaInline "hl.dsp.exec_cmd(\"dms ipc call powermenu toggle\")")
            ];
          }
          {
            _args = [
              (mkLuaInline "mod .. \" + Comma\"")
              (mkLuaInline "hl.dsp.exec_cmd(\"dms ipc call settings toggle\")")
            ];
          }
          {
            _args = [
              "SUPER + ALT + N"
              (mkLuaInline "hl.dsp.exec_cmd(\"dms ipc call night toggle\")")
              { locked = true; }
            ];
          }
          {
            _args = [
              "SUPER + ALT + L"
              (mkLuaInline "hl.dsp.exec_cmd(\"dms ipc call lock lock\")")
            ];
          }
          {
            _args = [
              "Print"
              (mkLuaInline "hl.dsp.exec_cmd(\"dms ipc call niri screenshot\")")
            ];
          }
          {
            _args = [
              "CTRL + Print"
              (mkLuaInline "hl.dsp.exec_cmd(\"dms ipc call niri screenshotScreen\")")
            ];
          }
          {
            _args = [
              "ALT + Print"
              (mkLuaInline "hl.dsp.exec_cmd(\"dms ipc call niri screenshotWindow\")")
            ];
          }
          {
            _args = [
              "XF86AudioRaiseVolume"
              (mkLuaInline "hl.dsp.exec_cmd(\"dms ipc call audio increment 3\")")
              { locked = true; repeating = true; }
            ];
          }
          {
            _args = [
              "XF86AudioLowerVolume"
              (mkLuaInline "hl.dsp.exec_cmd(\"dms ipc call audio decrement 3\")")
              { locked = true; repeating = true; }
            ];
          }
          {
            _args = [
              "XF86AudioMute"
              (mkLuaInline "hl.dsp.exec_cmd(\"dms ipc call audio mute\")")
              { locked = true; }
            ];
          }
          {
            _args = [
              "XF86AudioMicMute"
              (mkLuaInline "hl.dsp.exec_cmd(\"dms ipc call audio micmute\")")
              { locked = true; }
            ];
          }
          {
            _args = [
              "XF86AudioPlay"
              (mkLuaInline "hl.dsp.exec_cmd(\"dms ipc call mpris playPause\")")
              { locked = true; }
            ];
          }
          {
            _args = [
              "XF86AudioPrev"
              (mkLuaInline "hl.dsp.exec_cmd(\"dms ipc call mpris previous\")")
              { locked = true; }
            ];
          }
          {
            _args = [
              "XF86AudioNext"
              (mkLuaInline "hl.dsp.exec_cmd(\"dms ipc call mpris next\")")
              { locked = true; }
            ];
          }
          {
            _args = [
              "XF86MonBrightnessUp"
              (mkLuaInline "hl.dsp.exec_cmd(\"dms ipc call brightness increment 5\")")
              { locked = true; repeating = true; }
            ];
          }
          {
            _args = [
              "XF86MonBrightnessDown"
              (mkLuaInline "hl.dsp.exec_cmd(\"dms ipc call brightness decrement 5\")")
              { locked = true; repeating = true; }
            ];
          }
        ];

        window_rule = [
          {
            match = {
              class = "^firefox$";
              title = "^(Picture-in-Picture|画中画)$";
            };
            floating = true;
          }
          {
            match = { class = "^firefox$"; };
            scrolling_width = 0.5;
          }
          {
            match = { class = "^(org.quickshell)$"; };
            floating = true;
          }
          {
            match = { class = "^(kitty)$"; };
            border_size = 0;
          }
        ];
      };
    };
  };
}
