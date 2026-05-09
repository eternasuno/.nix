{
  darwin,
  home-manager,
  ...
} @ inputs: let
  vars = {
    host = "MacBook-Air";
    username = "eternasuno";
    email = "22316214+eternasuno@users.noreply.github.com";
    flakePath = "/Users/eternasuno/.nix";
    timeZone = "Asia/Tokyo";
    version = "25.05";
    darwinStateVersion = 6;
  };
in {
  darwinConfigurations.${vars.host} = darwin.lib.darwinSystem {
    system = "aarch64-darwin";
    specialArgs = {inherit inputs vars;};
    modules = [
      {
        nixpkgs.overlays = [inputs.purescript-overlay.overlays.default];
      }
      ./configuration.nix
      home-manager.darwinModules.home-manager
    ];
  };
}
