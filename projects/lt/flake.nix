{
  description = "LT environment";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
          "claude-code"
        ];
      };
    in {
      devShells.${system}.default = pkgs.mkShell {
        name = "lt";
        packages = with pkgs; [
          google-cloud-sdk
          nodejs_22
          pnpm
          pkg-config
          claude-code
        ];
        shellHook = ''
          	source /etc/dotfiles/lib/project-identity.sh

		local layout_file="./layout.sh"

		if [ -f "$id_file" ]; then
	  		export TMUXIFIER_LAYOUT_PATH="./layout.sh"
		fi
        '';
      };
    };
}
