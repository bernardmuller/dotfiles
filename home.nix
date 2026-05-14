{ config, pkgs, ...}:

{
	imports = [ 
		./modules/hyprland/default.nix
		./modules/hyprland/hyprlock.nix
		./modules/hyprland/hypridle.nix
	];

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
		libnotify
	];

	programs.git = {
		enable = true;
		userName = "bernardmuller";
		# email = "b.mullerjnr@gmail.com";
	};

	services.mako = {
  		enable = true;
  		settings = {
    			default-timeout = 5000;     # ms before notification disappears
    			border-radius = 6;
    			font = "JetBrains Mono 11";
  		};
	};
}
