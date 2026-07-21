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
			"webber" = {
				hostname = "10.233.1.1";
  				user = "bernard";
  				identityFile = "~/.ssh/webber_docker";
  				identitiesOnly = true;	
			};
			"bitbucket-lmx" = {
				 hostname = "bitbucket.org";
				 user = "git";
				 identityFile = "~/.ssh/lmx_ed25519";
				 identitiesOnly = true;
		        };
			"bitbucket-ctp" = {
				 hostname = "bitbucket.org";
				 user = "git";
				 identityFile = "~/.ssh/ctp_ed25519";
				 identitiesOnly = true;
		        };
		};
	};

	home.sessionVariables = {
		DOCKER_HOST = "ssh://webber";
	};

	home.file.".tmux.conf".text = ''
		set-option -g default-shell ${pkgs.bashInteractive}/bin/bash
		set-option -g default-command "${pkgs.bashInteractive}/bin/bash"
	'';

	programs.git = {
		enable = true;
		userName = "bernardmuller";
		ignores = [
			".devshell/"
		];
	};

	home.file.".config/herdr/config.toml".text = ''
	    [theme]
	    # Choose one of the built-in themes:
	    # name = "tokyo-night"          # Popular dark theme
	    # name = "catppuccin"         # Default
	    # name = "dracula"
	    name = "gruvbox"
	    # name = "one-dark"
	    # name = "kanagawa"
	    # name = "rose-pine"

	    # Optional: Auto-switch between light/dark
	    # auto_switch = true
	    # light_name = "catppuccin-latte"
	    # dark_name = "catppuccin"

	    # Custom color overrides (optional)
	    # [theme.custom]
	    # accent = "#a6e3a1"
	    # green = "#a6e3a1"
	    # red = "#f38ba8"
	    # yellow = "#f9e2af"
	    # panel_bg = "#1e1e2e"
	  '';

	  home.activation.ensureHerdrConfig = config.lib.dag.entryAfter ["writeBoundary"] ''
	    mkdir -p ${config.home.homeDirectory}/.config/herdr
	  '';

	programs.bash = {
		  enable = true;
		  shellAliases = {
			pg-stop-here = ''nix shell nixpkgs#postgresql_16 -c pg_ctl -D "$PWD/.devshell/postgres" stop'';
			new-project = "/etc/dotfiles/scripts/new-project-container.sh";
		  };
		  initExtra = ''
			launch_tmux() {
				local session
				session=$(basename "$PWD" | tr -d '.')
				local dir="$PWD"
				if tmux has-session -t "$session" 2>/dev/null; then
					tmux attach-session -t "$session"
					return
				fi
				tmux new-session -d -s "$session" -c "$dir" -n main
				tmux split-window -h -p 40 -t "$session:main" -c "$dir"
				tmux split-window -v -p 50 -t "$session:main.1" -c "$dir"
				tmux send-keys -t "$session:main.0" 'nvim' C-m
				tmux select-pane -t "$session:main.0"
				tmux attach-session -t "$session"
			}

			shell() {
				local dirname
				dirname=$(basename "$PWD")
				local flake_path="/etc/dotfiles/projects/$dirname"
				if [ ! -f "$flake_path/flake.nix" ]; then
					echo "no flake found for '$dirname' in dotfiles/projects/"
					return 1
				fi
				if [ "$1" = "-t" ]; then
					export -f launch_tmux
					nix develop "$flake_path" --command bash -c "launch_tmux"
					return
				fi
				nix develop "$flake_path"
			}

			dev() {
				local project=$1
				if [ -z "$project" ]; then
					echo "usage: dev <path-to-project-under-home>"
					return 1
				fi
				if [ ! -d "''${project}" ]; then
					echo "Project not found: ~/''$project"
					return 1
				fi
				cd ~/''${project} && shell -t
			}
		  '';
	};
}
