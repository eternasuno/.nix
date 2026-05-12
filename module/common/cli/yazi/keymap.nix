{vars, ...}: let
  inherit (vars) username;
in {
  home-manager.users.${username}.programs.yazi.keymap = {
    mgr.prepend_keymap = [
      {
        on = ["g" "i"];
        run = "plugin lazygit";
        desc = "Run lazygit";
      }
      {
        on = "l";
        run = "plugin smart-enter";
        desc = "Enter directory or open file";
      }
    ];
  };
}
