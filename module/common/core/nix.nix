{pkgs, ...}: {
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [
        "https://cache.nixos.org?priority=10"
        "https://niri.cachix.org"
        "https://darwin.cachix.org"
        "https://nvf.cachix.org"
        "https://home-manager.cachix.org"
        "https://lanzaboote.cachix.org"
        "https://cache.numtide.com"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
        "darwin.cachix.org-1:BgK2L96yU4i3OojKDVGH9nN65e58LWbPJrZNVgbsfTA="
        "nvf.cachix.org-1:GMQWiUhZ6ux9D5CvFFMwnc2nFrUHTeGaXRlVBXo+naI="
        "home-manager.cachix.org-1:wLVmpPs9J1Na6uhEkqcJcdSmPR61rd76jOnlps6zvM8="
        "lanzaboote.cachix.org-1:Nt9//zGmqkg1k5iu+B3bkj3OmHKjSw9pvf3faffLLNk="
        "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
      ];
      auto-optimise-store = true;
    };
  };

  environment.systemPackages = with pkgs; [nix-output-monitor nvd];

  nixpkgs = {
    config.allowUnfree = true;
  };
}
