{ inputs, ... }: {
  imports = [ inputs.zen-browser.homeModules.beta ];

  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;

    profiles.default = {
	settings = {
        	"zen.workspaces.continue-where-left-off" = true;
        	"zen.view.compact.hide-tabbar" = true;
        	"zen.urlbar.behavior" = "float";
      	};

	search = {
        	force = true;
        	default = "ddg";
      	};

      spacesForce = true;  
      spaces = {
        "Work" = {
          id = "cdd10fab-4fc5-494b-9041-325e5759195b";
          position = 2000;
          icon = "💼";
	};
      };

     	mods = [
     		"ecda11ae-d3fd-4052-8881-303b2504e3ce" 
	];

	userChrome = ''
    #navigator-toolbox {
      background-color: #2b2b2b;
    }

    #TabsToolbar {
      min-height: 28px;
    }

    .tab-icon-image {
      width: 16px;
      height: 16px;
    }
  '';
    };
  };
}
