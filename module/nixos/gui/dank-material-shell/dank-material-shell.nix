{inputs, ...}: {
  imports = [
    inputs.dms-plugin-registry.nixosModules.default
  ];

  programs.dux-shell = {
    enable = true;
    plugins = {
      commandRunner.enable = true;
      screenCaptureToolbar.enable = true;
    };
  };
}
