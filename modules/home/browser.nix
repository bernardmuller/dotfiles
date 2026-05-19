{ inputs, ... }: {
  imports = [ inputs.zen-browser.homeModules.beta ];

  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;

    profiles.default = {
      spacesForce = true;  
      spaces = {
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

     	programs.zen-browser.profiles.default.mods = [
     		"ecda11ae-d3fd-4052-8881-303b2504e3ce" 
	];
    };
  };
}
