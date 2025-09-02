{ pkgs, ... }:
{
  wayland.windowManager.river = {
    enable = true;
    extraConfig = builtins.readFile ./init.sh;
  };
  # Optionally, put your script in `my-river-init.sh` and point to it here
  home.packages = with pkgs; [
    wlr-randr
  ];
}
