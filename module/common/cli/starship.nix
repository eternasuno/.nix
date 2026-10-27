{vars, ...}: let
  inherit (vars) username;
in {
  home-manager.users.${username} = {
    programs.starship = {
      enable = true;
      settings = {
        add_newline = true;
        scan_timeout = 10;
        command_timeout = 300;

        continuation_prompt = "[▸▹ ](dimmed white)";

        format = ''
          $directory$git_branch$git_metrics$fill$cmd_duration$time
          $sudo$character
        '';

        character = {
          success_symbol = "[>](bold bright-green)";
          error_symbol = "[X](bold bright-red)";
          vimcmd_symbol = "[<](bold bright-green)";
        };

        cmd_duration = {
          format = " took [$duration]($style)";
        };

        fill = {
          symbol = "-";
          style = "dimmed green";
        };

        git_branch = {
          symbol = "git ";
        };

        git_metrics = {
          disabled = false;
        };

        sudo = {
          format = "[$symbol]($style)";
          style = "bold italic bright-red";
          symbol = "sudo ";
          disabled = false;
        };

        time = {
          disabled = false;
          format = " at [$time]($style)";
        };
      };
    };
  };
}
