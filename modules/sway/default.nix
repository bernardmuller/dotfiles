{ pkgs, lib, ... }:

{
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;

    # config = {
    #   modifier = "Mod4";
    #   terminal = "kitty";
    #   input."*" = {
    #     xkb_options = "altwin:swap_alt_win";
    #   };
    # };
    #
    # extraConfig = ''
    #   bindsym XF86MonBrightnessDown exec light -U 10
    #   bindsym XF86MonBrightnessUp exec light -A 10
    #
    #   bindsym XF86AudioRaiseVolume exec wpctl set-volume @DEFAULT_SINK@ 0.10+
    #   bindsym XF86AudioLowerVolume exec wpctl set-volume @DEFAULT_SINK@ 0.10-
    #   bindsym XF86AudioMute exec wpctl set-mute @DEFAULT_SINK@ toggle
    # '';
  };
}
