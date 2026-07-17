{pkgs, lib, ...}: {
  # Override opencode package to fix macOS code signing.
  # Bun 1.3.13 produces corrupted LC_CODE_SIGNATURE in compiled binaries,
  # causing macOS 26.x to SIGKILL the process on launch.
  # autoSignDarwinBinariesHook re-signs the binary with a valid ad-hoc signature.
  programs.opencode.package = pkgs.opencode.overrideAttrs (old: {
    nativeBuildInputs = (old.nativeBuildInputs or [])
      ++ lib.optionals pkgs.stdenv.isDarwin [pkgs.autoSignDarwinBinariesHook];
  });
}
