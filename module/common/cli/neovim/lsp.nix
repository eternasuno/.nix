{vars, ...}: let
  inherit (vars) username;
in {
  home-manager.users.${username}.programs.nvf.settings.vim = {
    lsp.enable = true;
    languages = {
      enableTreesitter = true;
      enableFormat = true;

      nix.enable = true;
      #rust.enable = true;
      typescript.enable = true;
      css.enable = true;
      html.enable = true;
      yaml.enable = true;
      markdown.enable = true;
      typst.enable = true;
    };

    lsp.formatOnSave = true;
  };
}
