{ lib, pkgs, ... }:
{
	services.hyprsunset = {
		enable = true;
		settings = {
			max-gamma = 150;
			profile = [
				{
					time = "7:30";
					identity = true;
				}
				{
					time = "18:00";
					temperature = 4500;
					gamma = 0.5;
				}
			];
		};
	};
}
