{
  vars,
  pkgs,
  ...
}: let
  inherit (vars) username;
in {
  programs.gpu-screen-recorder.enable = true;

  home-manager.users.${username} = {
    home.packages = with pkgs; [slurp jq satty dgop];
  };
}