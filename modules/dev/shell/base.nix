{ config, pkgs, lib, ... }:

{
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      add_newline = false;
      format = "$username$hostname$directory$git_branch$git_status$nix_shell$character";

      hostname = {
        ssh_only = false;
        format = "[@$hostname]($style) ";
      };

      directory = {
        truncation_length = 3;
        truncate_to_repo = false;
      };

      username = {
        show_always = true;
        format = "[$user]($style)";
      };

      nix_shell = {
        symbol = " ❄ ";
        format = "[$symbol$name]($style) ";
        style = "bold cyan";
      };

      character = {
        success_symbol = lib.mkDefault "[\\$](bold green)";
        error_symbol = "[\\$](bold red)";
      };
    };
  };
}
