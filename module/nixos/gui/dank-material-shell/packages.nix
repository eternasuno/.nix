{
  vars,
  pkgs,
  ...
}: let
  inherit (vars) username;
in {
  programs.gpu-screen-recorder.enable = true;

  home-manager.users.${username} = {
    home.packages = with pkgs; [slurp jq satty dux-gop];
    xdg.configFile."satty/config.toml".text = ''
      [font]
      family = "Maple Mono NL NF CN"
      style = "Regular"
      fallback = ["Maple Mono NL NF CN"]
    '';
  };
}