{
  description = "Project environment";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells.${system}.default = pkgs.mkShell {
        name = "sst";
        packages = with pkgs; [
		nodejs_22
          	pnpm
          	postgresql_17
		playwright-driver.browsers
        ];
        shellHook = ''
	  	export PLAYWRIGHT_BROWSERS_PATH=${pkgs.playwright-driver.browsers}
      		export PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS=true
      		export PLAYWRIGHT_HOST_PLATFORM_OVERRIDE="ubuntu-24.04"
        '';
      };
    };
}
