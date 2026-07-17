{vars, pkgs, lib, ...}: let
  inherit (vars) username;
in {
  home-manager.users.${username}.programs.opencode.package = pkgs.opencode.overrideAttrs (old: {
    nativeBuildInputs = (old.nativeBuildInputs or []) ++ [pkgs.darwin.sigtool];

    # Smoke test in build.ts runs the darwin binary before it's signed,
    # causing SIGKILL. Patch it to not abort the build.
    postPatch = (old.postPatch or "") + ''
      substituteInPlace packages/opencode/script/build.ts \
        --replace-fail 'process.exit(1)' \
        'console.warn("smoke test skipped, will be signed in postFixup")'
    '';

    postFixup = (old.postFixup or "") + ''
      codesign --force --sign - $out/bin/opencode
    '';
  });
}
