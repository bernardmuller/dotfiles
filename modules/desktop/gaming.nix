{ config, pkgs, ... }:

{
  programs.steam = {
    enable = true;
    # Optionally:
    # remotePlay.openFirewall = true;
    # dedicatedServer.openFirewall = true;
  };

  # Other gaming-related system bits go here:
  # hardware.opengl.driSupport32Bit = true;  # already implied by programs.steam
  # programs.gamemode.enable = true;
}
