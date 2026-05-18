{ config, pkgs, ... }:

{
  imports = [ ./base.nix ];

  programs.starship.settings = {
    username.style_user = "bold green";
    hostname.style = "bold #4F7942";
    directory.style = "bold blue";
    character.success_symbol = "[\\$](bold green)";
  };
}
