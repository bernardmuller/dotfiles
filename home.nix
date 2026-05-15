{ config, pkgs, inputs, ...}:

{
	imports = [ 
		./modules/hyprland/default.nix
		./modules/hyprland/hyprlock.nix
		./modules/hyprland/hypridle.nix
		./modules/hyprland/hyprsunset.nix
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
		wiremix
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

	programs.vicinae = {
  enable = true;

    		# package = pkgs.vicinae;
  systemd = {
    enable = true;
    autoStart = true; # default: false
    target = "hyprland-session.target";
    # environment = {
    #   USE_LAYER_SHELL = 1;
    # };
  };
  settings = {
    close_on_focus_loss = true;
    consider_preedit = true;
    pop_to_root_on_close = true;
    favicon_service = "twenty";
    search_files_in_root = true;
    font = {
      normal = {
        size = 12;
        family = "Maple Nerd Font";
      };
    };
    theme = {
      light = {
        name = "vicinae-light";
        icon_theme = "default";
      };
      dark = {
        name = "vicinae-dark";
        icon_theme = "default";
      };
    };
    launcher_window = {
      opacity = 0.98;
    };
  };
  extensions = with inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system}; [
     bluetooth
     nix
     power-profile
    # Extension names can be found in the link below, it's just the folder names
  ];
};

}
