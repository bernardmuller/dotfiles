{ config, pkgs, ... }:

{

	imports = [
    		../../modules/dev/shell/container.nix
    		../../modules/dev/shell/banner-container.nix
	];
	home.username = "bernard";
	home.homeDirectory = "/home/bernard";
	home.stateVersion = "25.11";

	programs.ssh = {
		enable = true;
		matchBlocks = {
			"github-lt" = {
				hostname = "github.com";
				user = "git";
				identityFile = "~/.ssh/lt_ed25519";
				identitiesOnly = true;
			};
			"webber" = {
				hostname = "10.233.1.1";
  				user = "bernard";
  				identityFile = "~/.ssh/webber_docker";
  				identitiesOnly = true;	
			};
		};
	};

	home.sessionVariables = {
		DOCKER_HOST = "ssh://webber";
	};

	programs.git = {
		enable = true;
		userName = "bernardmuller";
		ignores = [
			".devshell/"
		];
	};

	programs.bash = {
		  enable = true;
		  shellAliases = {
			pg-stop-here = ''nix shell nixpkgs#postgresql_16 -c pg_ctl -D "$PWD/.devshell/postgres" stop'';
			new-project = "/etc/dotfiles/scripts/new-project-container.sh";
		  };
		  initExtra = ''
			    # Enter the devShell for the current project.
			    # Looks up /etc/dotfiles/projects/<dirname>/flake.nix and enters that shell.
			    dev() {
				local dirname
				    dirname=$(basename "$PWD")
				      local flake_path="/etc/dotfiles/projects/$dirname"
				      if [ ! -f "$flake_path/flake.nix" ]; then
					echo "no flake found for '$dirname' in dotfiles/projects/"
					return 1
				      fi
				      nix develop "$flake_path"
			    }
		  '';
	};
}
