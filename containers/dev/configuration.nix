{ config, pkgs, inputs, unstablePkgs, ... }:

{
  users.users.bernard = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBY26prbNVsygyO7mRAMY+Z+uqhDCdvPN65C6QfkMruB"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEF+5SuAxaOz4ixlsYZnPeHsU7jnHdwCntjQIryrl2RQ"
    ];
  };

  security.sudo.wheelNeedsPassword = false;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  services.tailscale.enable = true;

  networking.defaultGateway = "10.233.1.1";
  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];
  networking.enableIPv6 = false;

  networking.firewall = {
    allowedTCPPorts = [ 
    	22 
	3000 
	3001
	3002
	8080 
	4321 
	5432
	6543
	5000
	6000
	1337
	5173
	6006
    ];
    trustedInterfaces = [ "tailscale0" ];
    allowedUDPPorts = [ config.services.tailscale.port ];
    checkReversePath = "loose";
  };

  environment.systemPackages = with pkgs; [
    	kitty.terminfo
    	neovim
  	tmux
  	git
	ripgrep
	fd
	fzf
	bat
	btop
	curl
	devenv
	direnv
	nix-direnv
	docker-client

  tree-sitter
  gcc
  ripgrep

        # LSPs
        pyright
        rust-analyzer
        typescript-language-server  # ts_ls
        lua-language-server          # lua_ls
        zls                          # zig
        clang-tools                  # clangd + clang-format
        vscode-langservers-extracted  # html, cssls, eslint
        tailwindcss-language-server
        prettierd
        stylua
        lazygit
    openssl
    unstablePkgs.herdr
    unstablePkgs.hunk
  ];

  systemd.tmpfiles.rules = [
  "d /run/postgresql 0755 root root -"
];

  system.activationScripts.seedNvim = {
    deps = [ "users" ];
    text = ''
      rm -rf /home/bernard/.config/nvim
      install -d -o bernard -g users -m 0755 /home/bernard/.config
      cp -rT ${inputs.nvim-cfg} /home/bernard/.config/nvim
      chown -R bernard:users /home/bernard/.config/nvim
      chmod -R u+rwX /home/bernard/.config/nvim
    '';
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.11";
} 
