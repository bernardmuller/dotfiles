{ lib, pkgs, config, ... }:
let
	monitor = "HDMI-A-1";
	username = config.home.username;
	capitalized_username = (lib.toUpper (builtins.substring 0 1 username) + (builtins.substring 1 (-1) username));
in
{
	programs.hyprlock = {
		enable = true;
		settings = {
			background = [
				{
					monitor = monitor;
					path = "~/walls/wallpaper.jpg";
					blur_passes = 3;
					blur_size = 7;
				}
			];

			label = {
				monitor = monitor;
				text = "Hi, ${capitalized_username}";
				color = "rgba(200, 200, 200, 1.0)";
    				font_size = 25;
    				position = "0, 0";
    				halign = "center";
    				valign = "center";
			};

			input-field = {
				monitor = monitor;
                		size = "300,50";
                		outline_thickness = 2;
                		dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
                		dots_spacing = 0.35; # Scale of dots' absolute size, 0.0 - 1.0
                		dots_center = true;
                		outer_color = "rgba(0, 0, 0, 0)";
                		inner_color = "rgba(0, 0, 0, 0.3)";
		                font_color = "rgb(230, 230, 230)";
		                fade_on_empty = false;
		                rounding = -1;
		                check_color = "rgb(30, 107, 204)";
				placeholder_text = ''<span foreground="#888888">Password</span>'';
		                hide_input = false;
		                position = "0, -60";
		                halign = "center";
               			valign = "center";
              		};
		};
	};
}
