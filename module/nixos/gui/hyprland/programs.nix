{pkgs, ...}: {
  programs.hyprland = {
    enable = true;
    package = let
      pkg = pkgs.symlinkJoin {
        name = "hyprland";
        paths = [pkgs.hyprland];
        inherit (pkgs.hyprland) pname version;
        meta = pkgs.hyprland.meta // {outputsToInstall = ["out"];};
        passthru.providedSessions = ["hyprland-uwsm"];
        postBuild = ''
          rm -f "$out/share/wayland-sessions/hyprland.desktop"
          rm -f "$out/share/wayland-sessions/hyprland-uwsm.desktop"
          cp "${pkgs.hyprland}/share/wayland-sessions/hyprland-uwsm.desktop" \
            "$out/share/wayland-sessions/hyprland-uwsm.desktop"
          sed -i "s|^Exec=|Exec=${pkgs.coreutils}/bin/env UWSM_SILENT_START=2 |" \
            "$out/share/wayland-sessions/hyprland-uwsm.desktop"
        '';
      };
    in
      pkg
      // {
        # NixOS checks this hook before applying package-specific options.
        override = _: pkg;
      };
    xwayland.enable = true;
    withUWSM = true;
  };
}
