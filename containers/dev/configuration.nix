{ config, pkgs, ... }:

{
  users.users.bernard = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBY26prbNVsygyO7mRAMY+Z+uqhDCdvPN65C6QfkMruB"
    ];
  };

  security.sudo.wheelNeedsPassword = false;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  services.tailscale.enable = true;

  networking.defaultGateway = "10.233.1.1";
  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];

  networking.firewall = {
    allowedTCPPorts = [ 22 ];
    trustedInterfaces = [ "tailscale0" ];
    allowedUDPPorts = [ config.services.tailscale.port ];
    checkReversePath = "loose";
  };

  environment.systemPackages = with pkgs; [
    kitty.terminfo
  ];

  system.stateVersion = "25.11";
} 
