{vars, pkgs, lib, ...}: let
  inherit (vars) username;
in {
  home-manager.users.${username}.programs.opencode.package = pkgs.opencode.overrideAttrs (old: {
    nativeBuildInputs = (old.nativeBuildInputs or []) ++ [pkgs.darwin.sigtool];
    postFixup = (old.postFixup or "") + ''
      codesign --force --sign - $out/bin/opencode
    '';
  });
}
