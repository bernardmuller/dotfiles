{ config, pkgs, inputs, ...}:
{
	programs.vicinae = {
  		enable = true;

		systemd = {
		    enable = true;
		    autoStart = true; # default: false
		    target = "hyprland-session.target";
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
		  ];

	};
}
