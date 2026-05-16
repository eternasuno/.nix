{
  inputs,
  vars,
  ...
}: let
  inherit (vars) username;
in {
  imports = [
    inputs.dankMaterialShell.nixosModules.greeter
  ];

  programs.dconf.enable = true;

  programs.niri = {
    enable = true;
    useNautilus = false;
  };

  programs.dank-material-shell.greeter = {
    enable = true;
    compositor.name = "niri";
    configHome = "/home/${username}";
  };
}
