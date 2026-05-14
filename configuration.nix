{ config, pkgs, inputs, ... }:

	
{
  	imports =
    	[ 
    		./hardware-configuration.nix
    	];

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "backup";
  home-manager.users.bernard = import ./home.nix;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "webber"; # Define your hostname.

  networking.networkmanager.enable = true;

  time.timeZone = "Africa/Johannesburg";

  i18n.defaultLocale = "en_ZA.UTF-8";

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
			command = "Hyprland";
			user = "bernard";
		};
	};
  };


  users.users.bernard = {
    isNormalUser = true;
    description = "Bernard";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim 
    kitty
    neovim
    btop
    lightdm
    pcmanfm
    rofi
    git
    pfetch
    unzip
    brave
	steam
	ckan
	spotify
    inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
  #  wget
  ];

  programs.steam.enable = true;
  programs.hyprland.enable = true;
  security.pam.services.hyprlock = {};

  fonts.packages = with pkgs; [
  	jetbrains-mono
  ];

  	nix.settings.experimental-features = [ "nix-command" "flakes" ];

    system.stateVersion = "25.11"; 

}
