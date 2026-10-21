{
  nixpkgs,
  home-manager,
  lanzaboote,
  nixos-hardware,
  ...
} @ inputs: let
  vars = {
    host = "nixos";
    username = "zhang";
    email = "22316214+eternasuno@users.noreply.github.com";
    flakePath = "/home/zhang/.nix";
    keyboardLayout = "us";
    timeZone = "Asia/Tokyo";
    version = "26.05";
  };
in {
  nixosConfigurations.${vars.host} = nixpkgs.lib.nixosSystem {
    system = "aarch64-linux";
    specialArgs = {inherit inputs vars;};
    modules = [
      ./incus.nix
      ./orbstack.nix
      ./configuration.nix
      home-manager.nixosModules.home-manager
    ];
  };
}
