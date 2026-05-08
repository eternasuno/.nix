{vars, ...}: let
  inherit (vars) username;
in {
  home-manager.users.${username}.programs.nvf.settings.vim.assistant.avante-nvim = {
    enable = true;
    setupOpts = {
      behaviour = {
        auto_suggestions = false;
        auto_set_highlight_group = true;
        auto_set_keymaps = true;
        auto_apply_diff_after_generation = false;
        support_paste_from_clipboard = true;
        minimize_diff = true;
        enable_token_counting = true;
        enable_cursor_planning_mode = false;
        enable_claude_text_editor_tool_mode = false;
      };

      windows = {
        position = "right";
        width = 35;
        wrap = true;

        edit = {
          border = "rounded";
          start_insert = true;
        };

        ask = {
          floating = false;
          start_insert = true;
          border = "rounded";
          focus_on_apply = "ours";
        };
      };

      diff = {
        autojump = true;
        override_timeoutlen = 500;
      };

      hints.enabled = true;
    };
  };
}
