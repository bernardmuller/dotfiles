{
	description = "i use nixos btw";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		awww.url = "git+https://codeberg.org/LGFae/awww";
		vicinae = {
    			url = "github:vicinaehq/vicinae";
    			inputs.nixpkgs.follows = "nixpkgs";
  		};
		vicinae-extensions = {
			url = "github:vicinaehq/extensions";
  			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, home-manager, ...}@inputs: {
		nixosConfigurations.webber = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			specialArgs = { inherit inputs; };
			modules = [ 
				./configuration.nix 
				./modules/dev/dev-container.nix
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
