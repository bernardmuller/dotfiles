{ config, pkgs, inputs, ...}:
{
	imports = [ 
		inputs.zen-browser.homeModules.beta
		./modules/hyprland/default.nix
		./modules/hyprland/waybar.nix
		./modules/launcher/vicinae.nix
		./modules/hyprland/hyprlock.nix
		./modules/hyprland/hypridle.nix
		./modules/hyprland/hyprsunset.nix
		./modules/home/terminal.nix
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


  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;

    profiles.default = {
      spacesForce = true;  
      spaces = {
        "Personal" = {
          id = "c6de089c-410d-4206-961d-ab11f988d40a";            position = 1000;

          icon = "🏠";
        };
        "Work" = {
          id = "cdd10fab-4fc5-494b-9041-325e5759195b";
          position = 2000;
          icon = "💼";
          theme = {
            type = "gradient";
            colors = [{
              red = 100; green = 150; blue = 200;
              algorithm = "floating";
              type = "explicit-lightness";
              lightness = 50;
            }];
            opacity = 0.8;
            texture = 0.5;
          };
        };
      };

      # --- Themes/mods from the Zen theme store ---
      # mods."<theme-id-from-zen-store>" = { enable = true; };
    };
  };
}
