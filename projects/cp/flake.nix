{
  description = "cp devShell";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pgData = "$PWD/.devshell/postgres";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
          "claude-code"
        ];
      };
    in {
      devShells.${system}.default = pkgs.mkShell {
      	name = "expenny";
        packages = with pkgs; [
          nodejs_22
          pnpm
          postgresql_16
          python3
          gcc
          gnumake
          pkg-config
	        typescript-language-server
  	      typescript
	        tsx
	        deno
          claude-code
        ];

        shellHook = ''
          export PGDATA="${pgData}"
          export PGHOST="$PWD/.devshell"
          export PGPORT=5433
          export PGDATABASE=expense_tracker
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
          echo "cp devShell ready."
          echo "  Node:     $(node --version)"
          echo "  pnpm:     $(pnpm --version)"
          echo "  Postgres: $(postgres --version | awk '{print $3}')"
          echo ""
          echo "Postgres commands:  pg_start | pg_stop | pg_psql | pg_createdb_if_missing"
          echo "Connection string:  $DATABASE_URL"
        '';
      };
    };
}
