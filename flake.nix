{
	description = "i use nixos btw";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		awww.url = "git+https://codeberg.org/LGFae/awww";
	};

	outputs = { self, nixpkgs, home-manager, ...}@inputs: {
		nixosConfigurations.webber = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			specialArgs = { inherit inputs; };
			modules = [ 
				./configuration.nix 
				home-manager.nixosModules.home-manager
				{
					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
						users.bernard = import ./home.nix;
						backupFileExtension = "backup";
					};
				}
			];
		};

	};
}
