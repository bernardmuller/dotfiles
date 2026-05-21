{ config, pkgs, ... }: 

{
	virtualisation.docker = {
		enable = true;
	};

	users.users.bernard.extraGroups = [ "docker" ];
}
