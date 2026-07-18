{
  vars,
  inputs,
  pkgs,
  ...
}: let
  inherit (vars) username;
in {
  home-manager.users.${username}.programs.opencode = {
    package = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.opencode;
  };
}
