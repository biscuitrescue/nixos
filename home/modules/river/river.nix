{ pkgs, ... }: {

  wayland.windowManager.river-classic = {
    enable = true;
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
          natural-scroll = true;
        };
      };
      map = {
        normal = {
          "Super Q" = "close";
          "Super D" = "spawn 'rofi -show drun'";
          "Super R" = "spawn 'rofi -show run'";
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
    };
  };

  home.packages = with pkgs; [
    wlr-randr
  ];
}
