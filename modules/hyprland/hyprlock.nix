{ lib, pkgs, ... }:
{
	programs.hyprlock = {
		enable = true;
		settings = {
			background = {
				path = ~/walls/wallpaper.jpg;
				blur_passes = 2;
			};
		};
	};
}
