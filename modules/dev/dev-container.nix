{ config, pkgs, inputs, unstablePkgs, ... }:
let
  homeManagerModule = "${inputs.home-manager}/nixos";
  homeNix = ../../containers/dev/home.nix;
  containerConfig = ../../containers/dev/configuration.nix;
in
{
  networking.nat = {
    enable = true;
    internalInterfaces = [ "ve-+" ];
    externalInterface = "enp34s0";
  };

  containers.dev = {
    autoStart = true;
    specialArgs = { 
      inherit inputs unstablePkgs;   # ← important
    };
    privateNetwork = true;
    hostAddress = "10.233.1.1";
    localAddress = "10.233.1.2";
    enableTun = true;
    additionalCapabilities = [ "CAP_NET_ADMIN" "CAP_SYS_ADMIN" ];

    bindMounts."/etc/dotfiles" = {
      hostPath = "/home/bernard/dotfiles";
      isReadOnly = true;
    };

    config = { config, pkgs, unstablePkgs, inputs, ... }: {
      imports = [
        containerConfig
        homeManagerModule
      ];

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.bernard = import homeNix;
        backupFileExtension = "backup";
      };
    };
  };
}
