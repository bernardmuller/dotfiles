{ config, pkgs, ... }: 
{
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

			services.tailscale.enable = true;

      			networking.firewall.allowedTCPPorts = [ 22 ];

			system.stateVersion = "25.11";
		};
	};
}
