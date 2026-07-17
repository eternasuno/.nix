{
  nixpkgs,
  home-manager,
  nixos-hardware,
  ...
} @ inputs: let
  vars = {
    host = "framework";
    username = "eternasuno";
    email = "22316214+eternasuno@users.noreply.github.com";
    flakePath = "/home/eternasuno/.nix";
    keyboardLayout = "us";
    timeZone = "Asia/Tokyo";
    version = "26.05";
  };
in {
  nixosConfigurations.${vars.host} = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {inherit inputs vars;};
    modules = [
      ./configuration.nix
      ./hardware-configuration.nix
      home-manager.nixosModules.home-manager
      nixos-hardware.nixosModules.framework-13-7040-amd
    ];
  };
}
