{vars, ...}: let
  inherit (vars) username;
in {
  home-manager.users.${username}.programs.nvf.settings.vim.keymaps = [
    {
      key = "K";
      mode = ["n"];
      action = "<cmd>lua vim.lsp.buf.hover()<CR>";
      silent = true;
      desc = "Show Documentation/Type";
    }
    {
      key = "gd";
      mode = ["n"];
      action = "<cmd>lua vim.lsp.buf.definition()<CR>";
      silent = true;
      desc = "Go to Definition";
    }
    {
      key = "gr";
      mode = ["n"];
      action = "<cmd>lua vim.lsp.buf.references()<CR>";
      silent = true;
      desc = "Find References";
    }
    {
      key = "gi";
      mode = ["n"];
      action = "<cmd>lua vim.lsp.buf.implementation()<CR>";
      silent = true;
      desc = "Go to Implementation";
    }
    {
      key = "<leader>D";
      mode = ["n"];
      action = "<cmd>lua vim.lsp.buf.type_definition()<CR>";
      silent = true;
      desc = "Go to Type Definition";
    }
    {
      key = "<leader>rn";
      mode = ["n"];
      action = "<cmd>lua vim.lsp.buf.rename()<CR>";
      silent = true;
      desc = "Rename Symbol";
    }
    {
      key = "<leader>ca";
      mode = ["n"];
      action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
      silent = true;
      desc = "Code Action";
    }
    {
      key = "<leader>cl";
      mode = ["n"];
      action = "<cmd>lua vim.lsp.codelens.run()<CR>";
      silent = true;
      desc = "Code Lens Action";
    }
    {
      key = "<leader>F";
      mode = ["n"];
      action = "<cmd>lua vim.lsp.buf.format()<CR>";
      silent = true;
      desc = "Format Buffer";
    }
    {
      key = "<C-k>";
      mode = ["i"];
      action = "<cmd>lua vim.lsp.buf.signature_help()<CR>";
      silent = true;
      desc = "Signature Help";
    }
    {
      key = "[d";
      mode = ["n"];
      action = "<cmd>lua vim.diagnostic.goto_prev()<CR>";
      silent = true;
      desc = "Previous Diagnostic";
    }
    {
      key = "]d";
      mode = ["n"];
      action = "<cmd>lua vim.diagnostic.goto_next()<CR>";
      silent = true;
      desc = "Next Diagnostic";
    }
    {
      key = "<leader>da";
      mode = ["n"];
      action = "<cmd>Telescope diagnostics<CR>";
      silent = true;
      desc = "Show All Diagnostics";
    }
    {
      key = "<leader>dc";
      mode = ["n"];
      action = "<cmd>lua vim.diagnostic.open_float(nil, {scope = 'cursor'})<CR>";
      silent = true;
      desc = "Show Cursor Diagnostics";
    }
    {
      key = "<leader>fe";
      mode = ["n" "v"];
      action = "<cmd>Telescope file_browser<CR>";
      silent = true;
      desc = "Telescope File Browser";
    }
  ];
}
