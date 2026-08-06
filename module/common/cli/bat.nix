{ pkgs, vars, ... }:
let
  inherit (vars) username;
in
{
  home-manager.users.${username} = {
    programs.bat = {
      enable = true;
      config = {
        pager = "less -FR";
        style = "full";
        theme = "Dracula";
      };
      extraPackages = with pkgs.bat-extras; [
        batman
        batgrep
      ];
    };

    home.sessionVariables = {
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
      MANROFFOPT = "-c";
    };

    home.shellAliases = {
      cat = "bat";
      grep = "batgrep";
      man = "batman";
    };
  };
}
