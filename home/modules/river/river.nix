{ pkgs, ... }:
{
  wayland.windowManager.river = {
    enable = true;
    # extraConfig = builtins.readFile ./init.sh;
    settings = {
      border-width = 2;
      declare-mode = [
        "locked"
          "normal"
          "passthrough"
      ];
      input = {
        pointer-1267-12608-MSFT0001 = {
          accel-profile = "flat";
          events = true;
          pointer-accel = -0.3;
          tap = true;
        };
      };
      map = {
        normal = {
          "Alt Q" = "close";
        };
      };
      rule-add = {
        "-app-id" = {
          "'bar'" = "csd";
          "'float*'" = {
            "-title" = {
              "'foo'" = "float";
            };
          };
        };
      };
      set-cursor-warp = "on-output-change";
      set-repeat = "50 300";
    #   spawn = [
    #   ];
    # };
  };
# Optionally, put your script in `my-river-init.sh` and point to it here
  home.packages = with pkgs; [
    wlr-randr
  ];
}
