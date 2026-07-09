{ config, pkgs, inputs, ...}:
{
	imports = [ 
		./modules/hyprland/default.nix
		./modules/hyprland/waybar.nix
		./modules/launcher/vicinae.nix
		./modules/hyprland/hyprlock.nix
		./modules/hyprland/hypridle.nix
		./modules/hyprland/hyprsunset.nix
		./modules/home/terminal.nix
		./modules/home/browser.nix
		./modules/dev/shell/webber.nix
		./modules/dev/shell/banner-webber.nix
		./modules/hyprland/hyprcursor.nix
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
			new-project = "~/dotfiles/scripts/new-project-host.sh";
			update-nvim = "nix flake lock --update-input nvim-cfg && sudo nixos-rebuild switch --flake .#webber && sudo nixos-container restart dev";
		};
	};

	home.packages = with pkgs; [
		bat
		waybar
		libnotify
		wiremix
		localsend
    		pcmanfm
    		brave
    		steam
    		ckan
    		spotify
		discord
		telegram-desktop
		teams-for-linux
		beekeeper-studio
		obsidian
	];

	programs.git.enable = true;

	services.mako = {
  		enable = true;
  		settings = {
    			default-timeout = 5000;  
    			border-radius = 6;
    			font = "JetBrains Mono 11";
  		};
	};
}
