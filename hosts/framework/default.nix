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
    resumeDevice = "/dev/disk/by-uuid/ba50d7d6-da94-4d40-af3e-bd1e6879fa64";
    timeZone = "Asia/Tokyo";
    version = "26.11";
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
