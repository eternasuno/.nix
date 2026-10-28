{
  vars,
  pkgs,
  ...
}: let
  inherit (vars) username;
in {
  programs = {
    dux-shell.enable = true;
    gpu-screen-recorder.enable = true;
  };

  environment.systemPackages = with pkgs; [slurp jq satty dux-gop];

  home-manager.users.${username}.xdg.configFile."satty/config.toml".text = ''
    [font]
    family = "Maple Mono NL NF CN"
    style = "Regular"
    fallback = ["Maple Mono NL NF CN"]
  '';
}
