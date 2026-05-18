{ config, pkgs, ... }:

{
	imports = [ ./base.nix ];

	programs.starship.settings = {
		username.style_user = "bold green";
		hostname.style = "bold #fe8019";
		directory.style = "bold yellow";
		character.success_symbol = "[\\$](bold #d3869b)";
	};
}
