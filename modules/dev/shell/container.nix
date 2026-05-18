{ config, pkgs, ... }:

{
  imports = [ ./base.nix ];

  programs.starship.settings = {
    username.style_user = "bold magenta";
    hostname.style = "bold magenta";
    directory.style = "bold yellow";
    character.success_symbol = "[\\$](bold magenta)";
  };
}
