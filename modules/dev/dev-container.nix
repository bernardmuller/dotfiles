{ config, pkgs, ... }: 
{
	networking.nat = {
		enable = true;
		internalInterfaces = [ "ve-+" ];
		externalInterface = "wlp37s0";
	};

	containers.dev = {
		autoStart = true;
	
		privateNetwork = true;
		hostAddress = "10.233.1.1";
		localAddress = "10.233.1.2";

		enableTun = true;         
		additionalCapabilities = [ "CAP_NET_ADMIN" "CAP_SYS_ADMIN" ];

		config = import ../../containers/dev/configuration.nix;
	};
}
