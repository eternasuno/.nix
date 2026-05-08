{ vars, ... }:
let
  inherit (vars) username;
in
{
  home-manager.users.${username}.programs.nvf.settings.vim = {
    utility.diffview-nvim.enable = true;
    git = {
      enable = true;
      git-conflict = {
        enable = true;
      };
      gitsigns = {
        enable = true;
        codeActions.enable = true;
      };
      neogit = {
        enable = true;
      };
    };

    keymaps = [
      {
        key = "<leader>gs";
        mode = ["n"];
        action = "<cmd>Neogit kind=split<CR>";
        silent = true;
        desc = "Git status (Neogit)";
      }
      {
        key = "<leader>gd";
        mode = ["n"];
        action = "<cmd>DiffviewOpen<CR>";
        silent = true;
        desc = "Git diff view";
      }
      {
        key = "<leader>gD";
        mode = ["n"];
        action = "<cmd>DiffviewClose<CR>";
        silent = true;
        desc = "Close diff view";
      }
      {
        key = "<leader>gp";
        mode = ["n"];
        action = "<cmd>Gitsigns preview_hunk<CR>";
        silent = true;
        desc = "Preview current hunk";
      }
      {
        key = "<leader>ga";
        mode = ["n" "v"];
        action = "<cmd>Gitsigns stage_hunk<CR>";
        silent = true;
        desc = "Stage hunk (partial add)";
      }
      {
        key = "<leader>gu";
        mode = ["n"];
        action = "<cmd>Gitsigns undo_stage_hunk<CR>";
        silent = true;
        desc = "Undo staged hunk";
      }
      {
        key = "<leader>gr";
        mode = ["n" "v"];
        action = "<cmd>Gitsigns reset_hunk<CR>";
        silent = true;
        desc = "Reset hunk";
      }
      {
        key = "]h";
        mode = ["n"];
        action = "<cmd>Gitsigns next_hunk<CR>";
        silent = true;
        desc = "Next hunk";
      }
      {
        key = "[h";
        mode = ["n"];
        action = "<cmd>Gitsigns prev_hunk<CR>";
        silent = true;
        desc = "Previous hunk";
      }
      {
        key = "<leader>co";
        mode = ["n"];
        action = "<cmd>GitConflictChooseOurs<CR>";
        silent = true;
        desc = "Conflict choose ours";
      }
      {
        key = "<leader>ct";
        mode = ["n"];
        action = "<cmd>GitConflictChooseTheirs<CR>";
        silent = true;
        desc = "Conflict choose theirs";
      }
      {
        key = "<leader>cb";
        mode = ["n"];
        action = "<cmd>GitConflictChooseBoth<CR>";
        silent = true;
        desc = "Conflict choose both";
      }
      {
        key = "<leader>c0";
        mode = ["n"];
        action = "<cmd>GitConflictChooseNone<CR>";
        silent = true;
        desc = "Conflict choose none";
      }
      {
        key = "]x";
        mode = ["n"];
        action = "<cmd>GitConflictNextConflict<CR>";
        silent = true;
        desc = "Next conflict";
      }
      {
        key = "[x";
        mode = ["n"];
        action = "<cmd>GitConflictPrevConflict<CR>";
        silent = true;
        desc = "Previous conflict";
      }
      {
        key = "<leader>cq";
        mode = ["n"];
        action = "<cmd>GitConflictListQf<CR>";
        silent = true;
        desc = "List conflicts";
      }
    ];
  };
}
