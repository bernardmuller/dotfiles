{ config, pkgs, ... }: 
{
	containers.work = {
		autoStart = true;
		config = { config, pkgs, ... }: {
			users.users.bernard = {
        			isNormalUser = true;
        			extraGroups = [ "wheel" ];
        			initialPassword = "changeme";
      			};


			system.stateVersion = "25.11";
		};
	};
}
