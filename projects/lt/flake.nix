{
  description = "LT environment";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells.${system}.default = pkgs.mkShell {
        name = "lt";
        packages = with pkgs; [
		google-cloud-sdk
		nodejs_22
          	pnpm
          	pkg-config
        ];
        shellHook = ''
          source /etc/dotfiles/lib/project-identity.sh
        '';
      };
    };
}
