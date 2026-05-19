{vars, lib, ...}: let
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
          clear_suggestion = "<C-e>";
          accept_word = "<C-j>";
        };
      };
    };

    augroups = [{
      name = "cmp_nil_compat";
      clear = true;
    }];
    autocmds = [{
      event = ["InsertEnter" "CmdlineEnter"];
      group = "cmp_nil_compat";
      once = true;
      callback = lib.generators.mkLuaInline ''
        function()
          pcall(function()
            require("lz.n").trigger_load("nvim-cmp")
          end)

          local ok, entry = pcall(require, "cmp.entry")
          if not ok or entry._fill_defaults_with_nil_compat then
            return
          end

          local function normalize_lsp_null(value, seen)
            if value == vim.NIL then return nil end
            if type(value) ~= "table" then return value end
            seen = seen or {}
            if seen[value] then return seen[value] end
            local normalized = {}
            seen[value] = normalized
            for key, nested in pairs(value) do
              local nv = normalize_lsp_null(nested, seen)
              if nv ~= nil then normalized[key] = nv end
            end
            return normalized
          end

          local original_fill_defaults = entry.fill_defaults
          entry.fill_defaults = function(self, completion_item, defaults)
            return original_fill_defaults(
              self,
              normalize_lsp_null(completion_item) or {},
              normalize_lsp_null(defaults) or defaults
            )
          end
          entry._fill_defaults_with_nil_compat = true
        end
      '';
    }];
  };
}
