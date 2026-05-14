{ lib, pkgs, config, ... }:
{
	services.hypridle = {
		enable = true;
		settings = {
			listener = [
				{
					timeout = 30;
					on-timeout = "notify-send 'You are idle'";
					on-resume = "notify-send 'Welcome Back!'";
				}
			];
		};
	};
}
