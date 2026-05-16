{ config, pkgs, ... }: 
{
	home.pointerCursor = {
		gtk.enable = true;
		name = "volantes_light_cursors";
		package = pkgs.runCommand "my-cursor-theme" {} ''
			mkdir -p $out/share/icons
			cp -r ${./.icons/volantes_light_cursors} $out/share/icons/volantes_light_cursors
		'';
		size = 12;
		hyprcursor.enable = true;
		hyprcursor.size = 12;
	};
}
