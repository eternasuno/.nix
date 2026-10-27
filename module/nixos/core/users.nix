{ vars, ... }:
let
  inherit (vars) username keyboardLayout;
in
{
  console.keyMap = keyboardLayout;

  users = {
    users.${username} = {
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "video"
        "wheel"
      ];
    };
  };
}
