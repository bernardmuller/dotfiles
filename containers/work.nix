{ config, pkgs, ... }: 
{
	networking.nat = {
		enable = true;
		internalInterfaces = [ "ve-+" ];
		externalInterface = "wlp37s0";
	};

	containers.work = {
		autoStart = true;
	
		privateNetwork = true;
		hostAddress = "10.233.1.1";
		localAddress = "10.233.1.2";

		enableTun = true;         
		additionalCapabilities = [ "CAP_NET_ADMIN" "CAP_SYS_ADMIN" ];

		config = { config, pkgs, ... }: {
			users.users.bernard = {
        			isNormalUser = true;
        			extraGroups = [ "wheel" ];
				openssh.authorizedKeys.keys = [
          				"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBY26prbNVsygyO7mRAMY+Z+uqhDCdvPN65C6QfkMruB"
        			];
      			};

			security.sudo.wheelNeedsPassword = false;

			environment.systemPackages = with pkgs; [
  				kitty.terminfo
			];

			services.openssh = {
			        enable = true;
        			settings = {
          				PasswordAuthentication = false;
          				PermitRootLogin = "no";
        			};
      			};

			# 1. Enable the service and the firewall
			services.tailscale.enable = true;
			networking.nftables.enable = true;
			networking.firewall = {
			  enable = true;
			  # Always allow traffic from your Tailscale network
			  trustedInterfaces = [ "tailscale0" ];
			  # Allow the Tailscale UDP port through the firewall
			  allowedUDPPorts = [ config.services.tailscale.port ];
			  checkReversePath = "loose";
			};

			networking.defaultGateway = "10.233.1.1";
      			networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];

			# 2. Force tailscaled to use nftables (Critical for clean nftables-only systems)
			# This avoids the "iptables-compat" translation layer issues.
			systemd.services.tailscaled.serviceConfig.Environment = [ 
			  "TS_DEBUG_FIREWALL_MODE=nftables" 
			];

			# 3. Optimization: Prevent systemd from waiting for network online 
			# (Optional but recommended for faster boot with VPNs)
			systemd.network.wait-online.enable = false; 
			boot.initrd.systemd.network.wait-online.enable = false;

      			networking.firewall.allowedTCPPorts = [ 22 ];

			system.stateVersion = "25.11";
		};
	};
}
