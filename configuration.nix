{ config, pkgs, inputs, ... }:

	
{
  	imports =
    	[ 
    		./hardware-configuration.nix
		./modules/dev/docker.nix
		./modules/desktop/gaming.nix
    	];

  # home-manager.useUserPackages = true;
  # home-manager.useGlobalPkgs = true;
  # home-manager.extraSpecialArgs = { inherit inputs; };
  # home-manager.users.bernard = import ./home.nix;
  # home-manager.backupFileExtension = "backup";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "webber"; # Define your hostname.
  networking.firewall.trustedInterfaces = [ "ve-+" ];
  networking.firewall.allowedTCPPorts = [ 53317 47984 47989 48010 47990 ];
  networking.firewall.allowedUDPPorts = [ 53317  47998 47999 48000 48002 48010 ];
  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true;
hardware.bluetooth.powerOnBoot = true;
services.blueman.enable = true; 

  time.timeZone = "Africa/Johannesburg";

  i18n.defaultLocale = "en_ZA.UTF-8";

  fileSystems."/mnt/nvme" = {
	device = "/dev/disk/by-uuid/44951677-c59c-42cc-8b1c-0e8a2345eec7";
	fsType = "ext4";
	options = [ "nofail" "rw"];
  };

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.greetd = {
	enable = true;
	settings = rec {
		default_session = {
			command = "start-hyprland";
			user = "bernard";
		};
	};
  };

  services.openssh = {
  	enable = true;
	settings = {
		PasswordAuthentication = false;
		PermitRootLogin = "no";
	};
  };

  users.users.bernard = {
    isNormalUser = true;
    description = "Bernard";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
    #  thunderbird
    ];
    openssh.authorizedKeys.keys = [
    	"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF6bW1CqD/eco2vcdZe0vMDgU+XZlUXp9Ad63Z91kP9F dev-container-to-webber"
    ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim 
    kitty
    neovim
    btop
    lightdm
    git
    pfetch
    zip
    unzip
    unrar
    p7zip
    inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
    sunshine
    bluetui
    lazygit
    tree-sitter
    gcc
    ripgrep
    satty
  ];

  programs.hyprland.enable = true;
  security.pam.services.hyprlock = {};

  fonts.packages = with pkgs; [
  	jetbrains-mono
  ];

  	nix.settings.experimental-features = [ "nix-command" "flakes" ];

    system.stateVersion = "25.11"; 

}
