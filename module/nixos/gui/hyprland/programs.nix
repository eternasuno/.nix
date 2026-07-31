{
  pkgs,
  vars,
  ...
}: let
  inherit (vars) username;
in {
  programs.hyprland = {
    enable = true;
    package = let
      pkg = pkgs.stdenv.mkDerivation {
        pname = pkgs.hyprland.pname;
        version = pkgs.hyprland.version;
        src = pkgs.hyprland;
        passthru = {
          providedSessions = ["hyprland-uwsm"];
        };
        meta =
          pkgs.hyprland.meta
          // {
            outputsToInstall = ["out"];
          };
        phases = ["installPhase"];
        installPhase = ''
          mkdir -p "$out/share/wayland-sessions"
          cp -a "$src/." "$out/"
          chmod -R u+w "$out"
          rm -f "$out/share/wayland-sessions/hyprland.desktop"
          # Silence `uwsm start` output on the VT. Without it, uwsm prints its
          # startup status to the console between the greeter compositor
          # exiting and the session Hyprland rendering, showing up as a flash
          # of console text ("command line") right after login.
          sed -i "s|^Exec=|Exec=${pkgs.coreutils}/bin/env UWSM_SILENT_START=2 |" "$out/share/wayland-sessions/hyprland-uwsm.desktop"
        '';
      };
    in
      pkg
      // {
        override = _: pkg;
      };
    xwayland.enable = true;
    withUWSM = true;
  };

  home-manager.users.${username} = {
    home.file.".local/share/wayland-sessions/hyprland.desktop" = {
      text = ''
        [Desktop Entry]
        Name=Hyprland
        Comment=An intelligent dynamic tiling Wayland compositor
        Exec=${pkgs.hyprland}/bin/start-hyprland
        Type=Application
        DesktopNames=Hyprland
        Keywords=tiling;wayland;compositor;
      '';
    };
  };
}
