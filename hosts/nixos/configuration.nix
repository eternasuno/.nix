# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  vars,
  modulesPath,
  inputs,
  ...
}: let
  inherit (vars) username version;
in {
  imports = [
    # Include the default lxd configuration.
    "${modulesPath}/virtualisation/lxc-container.nix"
    ../../module/common/cli/bash.nix
    ../../module/common/cli/bat.nix
    ../../module/common/cli/devenv.nix
    ../../module/common/cli/gh.nix
    ../../module/common/cli/git.nix
    ../../module/common/cli/lazygit.nix
    ../../module/common/cli/maki
    ../../module/common/cli/neovim
    ../../module/common/cli/nh.nix
    ../../module/common/cli/starship.nix
    ../../module/common/cli/zoxide.nix
    ../../module/common/core/fonts.nix
    ../../module/common/core/nix.nix
    ../../module/nixos/core/nix-ld.nix
  ];

  home-manager = {
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {inherit vars inputs;};
    users.${username} = {
      home = {
        username = username;
        homeDirectory = "/home/${username}";
        stateVersion = version;
      };
    };
  };

  users.users.zhang = {
    uid = 502;
    extraGroups = ["wheel" "orbstack"];

    # simulate isNormalUser, but with an arbitrary UID
    isSystemUser = true;
    group = "users";
    createHome = true;
    home = "/home/zhang";
    homeMode = "700";
    useDefaultShell = true;
  };

  security.sudo.wheelNeedsPassword = false;

  # This being `true` leads to a few nasty bugs, change at your own risk!
  users.mutableUsers = false;

  time.timeZone = "Asia/Tokyo";

  networking = {
    dhcpcd.enable = false;
    useDHCP = false;
    useHostResolvConf = false;
  };

  systemd.network = {
    enable = true;
    networks."50-eth0" = {
      matchConfig.Name = "eth0";
      networkConfig = {
        DHCP = "ipv4";
        IPv6AcceptRA = true;
      };
      linkConfig.RequiredForOnline = "routable";
    };
  };

  # Extra certificates from OrbStack.
  security.pki.certificates = [
    ''
            -----BEGIN CERTIFICATE-----
      MIICDDCCAbKgAwIBAgIQaWYyDp/ddF0Vyy3oo5fxYjAKBggqhkjOPQQDAjBmMR0w
      GwYDVQQKExRPcmJTdGFjayBEZXZlbG9wbWVudDEeMBwGA1UECwwVQ29udGFpbmVy
      cyAmIFNlcnZpY2VzMSUwIwYDVQQDExxPcmJTdGFjayBEZXZlbG9wbWVudCBSb290
      IENBMB4XDTI0MDkxMjAwNTUyOFoXDTM0MDkxMjAwNTUyOFowZjEdMBsGA1UEChMU
      T3JiU3RhY2sgRGV2ZWxvcG1lbnQxHjAcBgNVBAsMFUNvbnRhaW5lcnMgJiBTZXJ2
      aWNlczElMCMGA1UEAxMcT3JiU3RhY2sgRGV2ZWxvcG1lbnQgUm9vdCBDQTBZMBMG
      ByqGSM49AgEGCCqGSM49AwEHA0IABHhTHHGC07kQ7sKGigAWI0g1qSZsDrGErmZ+
      CvYYPK2EXRxHYQJCC8G+5cmiF+9M7C5a/jW++b+B11XSRVbdHiOjQjBAMA4GA1Ud
      DwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBQ0mbXt2K9IWzEf
      ahAOrjL2oVtU1TAKBggqhkjOPQQDAgNIADBFAiAN0UvTh5HErAejmwuaagD3+IcW
      kNboZCXf990orbusjAIhAI0LJrvZ/yRjZhtbTPbQY7YGBVmdR1h4zgN51oSt0cb1
      -----END CERTIFICATE-----

      -----BEGIN CERTIFICATE-----
      MIICDDCCAbKgAwIBAgIQaWYyDp/ddF0Vyy3oo5fxYjAKBggqhkjOPQQDAjBmMR0w
      GwYDVQQKExRPcmJTdGFjayBEZXZlbG9wbWVudDEeMBwGA1UECwwVQ29udGFpbmVy
      cyAmIFNlcnZpY2VzMSUwIwYDVQQDExxPcmJTdGFjayBEZXZlbG9wbWVudCBSb290
      IENBMB4XDTI0MDkxMjAwNTUyOFoXDTM0MDkxMjAwNTUyOFowZjEdMBsGA1UEChMU
      T3JiU3RhY2sgRGV2ZWxvcG1lbnQxHjAcBgNVBAsMFUNvbnRhaW5lcnMgJiBTZXJ2
      aWNlczElMCMGA1UEAxMcT3JiU3RhY2sgRGV2ZWxvcG1lbnQgUm9vdCBDQTBZMBMG
      ByqGSM49AgEGCCqGSM49AwEHA0IABHhTHHGC07kQ7sKGigAWI0g1qSZsDrGErmZ+
      CvYYPK2EXRxHYQJCC8G+5cmiF+9M7C5a/jW++b+B11XSRVbdHiOjQjBAMA4GA1Ud
      DwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBQ0mbXt2K9IWzEf
      ahAOrjL2oVtU1TAKBggqhkjOPQQDAgNIADBFAiAN0UvTh5HErAejmwuaagD3+IcW
      kNboZCXf990orbusjAIhAI0LJrvZ/yRjZhtbTPbQY7YGBVmdR1h4zgN51oSt0cb1
      -----END CERTIFICATE-----

    ''
  ];

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = version; # Did you read the comment?
}
