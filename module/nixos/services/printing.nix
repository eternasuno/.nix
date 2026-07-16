{ pkgs, ... }: {
  services.printing = {
    enable = true;
    drivers = with pkgs; [ gutenprint ];
  };

  environment.systemPackages = [ pkgs.cups-pk-helper ];
}
