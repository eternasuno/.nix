{vars, ...}: let
  inherit (vars) username;
in {
  home-manager.users.${username}.programs.nvf.settings.vim = {
    autocomplete.nvim-cmp = {
      enable = true;
      mappings = {
        next = "<C-n>";
        previous = "<C-p>";
        confirm = "<CR>";
      };
    };

    assistant.supermaven-nvim = {
      enable = true;
      setupOpts = {
        keymaps = {
          accept_suggestion = "<Tab>";
          clear_suggestion = "<C-]>";
          accept_word = "<C-j>";
        };
      };
    };
  };
}
