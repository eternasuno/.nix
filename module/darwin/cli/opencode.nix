{vars, pkgs, lib, ...}: let
  inherit (vars) username;
in {
  home-manager.users.${username}.programs.opencode.package = pkgs.opencode.overrideAttrs (old: {
    nativeBuildInputs = (old.nativeBuildInputs or []) ++ [pkgs.darwin.sigtool];

    # Smoke test in build.ts runs darwin binary before signing → SIGKILL.
    postPatch = (old.postPatch or "") + ''
      substituteInPlace packages/opencode/script/build.ts \
        --replace-fail 'process.exit(1)' \
        'console.warn("smoke test skipped, will be signed in postInstall")'
    '';

    # Sign before postInstall runs shell completions on the binary.
    postInstall = ''
      codesign --force --sign - $out/bin/opencode
    '' + (old.postInstall or "");
  });
}
