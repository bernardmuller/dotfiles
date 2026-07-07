{
  description = "Project environment";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  inputs.nixpkgs-playwright.url = "github:NixOS/nixpkgs/80d901ec0377e19ac3f7bb8c035201e2e098cc97";

  outputs = { self, nixpkgs, nixpkgs-playwright }:
    let
      system = "x86_64-linux";
      pgData = "$PWD/.devshell/postgres";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
          "claude-code"
          "ngrok"
        ];
      };    
      playwright = (import nixpkgs-playwright { inherit system; }).playwright-driver;
    in {
      devShells.${system}.default = pkgs.mkShell {
        name = "lmx";
        packages = with pkgs; [
          nodejs_24
          pnpm
          postgresql_18
          python3
          gcc
          gnumake
          pkg-config
	        typescript-language-server
  	      typescript
	        tsx
	        deno
          claude-code
          awscli2
          docker
          docker-compose
          playwright.browsers
          ngrok
        ];
        shellHook = ''
          source /etc/dotfiles/lib/project-identity.sh
          
          export PGDATA="${pgData}"
          export PGHOST="$PWD/.devshell"
          export PGPORT=5433
          export PGDATABASE=lumix
          export PGUSER=$(whoami)

          if [ ! -d "$PGDATA" ]; then
            echo "Initializing project-local Postgres at $PGDATA"
            mkdir -p "$PGDATA" "$PGHOST"
            initdb --auth=trust --no-locale --encoding=UTF8 --username="$PGUSER" "$PGDATA" >/dev/null
            echo "unix_socket_directories = '$PGHOST'" >> "$PGDATA/postgresql.conf"
            echo "listen_addresses = '''"                >> "$PGDATA/postgresql.conf"
            echo "port = $PGPORT"                       >> "$PGDATA/postgresql.conf"
          fi

          pg_start() { pg_ctl -D "$PGDATA" -l "$PGHOST/postgres.log" start; }
          pg_stop()  { pg_ctl -D "$PGDATA" stop; }
          pg_psql()  { psql -h "$PGHOST" -p "$PGPORT" "$@"; }
          pg_createdb_if_missing() {
            pg_start >/dev/null 2>&1 || true
            createdb -h "$PGHOST" -p "$PGPORT" "$PGDATABASE" 2>/dev/null || true
          }

          # export DATABASE_URL="postgres://$PGUSER@localhost:$PGPORT/$PGDATABASE?host=$PGHOST"

          echo ""
          echo "expense-tracker devShell ready."
          echo "  Node:     $(node --version)"
          echo "  pnpm:     $(pnpm --version)"
          echo "  Postgres: $(postgres --version | awk '{print $3}')"
          echo ""
          echo "Postgres commands:  pg_start | pg_stop | pg_psql | pg_createdb_if_missing"
          echo "Connection string:  $DATABASE_URL"

          PRJ_ROOT=$(git rev-parse --show-toplevel 2>/dev/null || echo "$PWD")

          if [ -f "$PRJ_ROOT/.env.aws" ]; then
            source "$PRJ_ROOT/.env.aws"
          fi

          export PLAYWRIGHT_BROWSERS_PATH="${playwright.browsers}"
          export PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD=1
        
        '';
      };
    };
}
