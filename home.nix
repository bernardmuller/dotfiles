{ config, pkgs, ...}:

{
	imports = [ ./modules/hyprland/default.nix ];

	home.username = "bernard";
	home.homeDirectory = "/home/bernard";
	home.stateVersion = "25.05";

	programs.bash = {
		enable = true;
		shellAliases = {
			btw = "echo i use nixos btw";
			nrs = "sudo nixos-rebuild switch --flake ~/dotfiles#webber";
			hr = "sudo rm -rf ~/.config/hypr && nrs";
		};

		initExtra = ''
		 	export PS1='\[\e[38;5;46m\]\u\[\e[0m\] in \[\e[38;5;39m\]\w\[\e[0m\] \\$ '
		'';
	};

	home.packages = with pkgs; [
		bat
		waybar
	];

	programs.git = {
		enable = true;
		userName = "bernardmuller";
		# email = "b.mullerjnr@gmail.com";
	};
}
