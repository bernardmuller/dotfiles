{ lib, pkgs, config, ... }:
{
	services.hypridle = {
		enable = true;
		settings = {
			general = {
				lock_cmd = "pidof hyprlock || hyprlock";
				before_sleep_cmd = "loginctl lock-session";
				after_sleep_cmd= "hyprctl dispatch dpms on";
			};

			listener = [
				{
					timeout = 300;
					on-timeout = "pidof hyprlock || hyprlock";
				}
				{
					timeout = 600;
					on-timeout = "hyprctl dispatch dpms off";
					on-resume = "hyprctl dispatch dpms on && hyprctl reload";
				}
				{
					timeout = 1800;
					on-timeout = "systemctl suspend";
				}
			];
		};
	};
}
