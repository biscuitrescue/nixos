{
  pkgs,
  inputs,
  ...
}: {
  wayland.windowManager.hyprland = {
    systemd.variables = ["--all"];
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    xwayland.enable = true;

    extraConfig = ''

layerrule = blur, waybar

windowrule=float,class:org.gnome.Nautilus
windowrule=size 1319 821,class:org.gnome.Nautilus

animations {
    bezier=overshot,0.13,0.99,0.29,1.1
    animation=windows,1,4,default,popin 80%
    animation=border,1,10,default
    animation=fade,1,10,default
    animation=workspaces,1,6,default,slide
    animation=specialWorkspace,1,4,overshot,slidevert
    enabled=1
}
    '';

    settings = {
      # exec = [
        # "swaybg -i ~/Pictures/wallpapers/Darth_vader.png"
      # ];
      exec-once = [
        "battery"
        "waybar"
        "nm-applet"
        "cppswap"
        "swayidle -w timeout 900 'wayblur' before-sleep 'wayblur'"
      ];
      decoration = {
        rounding = "6";
        blur = {
          enabled = true;
          size = 4;
          passes = 2;
        };
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      xwayland = {
        force_zero_scaling = true;
      };

      cursor.no_hardware_cursors = 1;
      input = {
        kb_layout = "us";
        # sensitivity = 0.15;
        follow_mouse = 1;
        touchpad = {
          natural_scroll = true;
          drag_lock = true;
        };
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_distance = 200;
        workspace_swipe_forever = true;
      };

      monitor = "eDP-1, 1920x1080@59.99900, auto, 1";

      general = {
        gaps_in = 2;
        gaps_out = 6;
        border_size = 2;
        "col.active_border" = "0xff95aec7";
        "col.inactive_border" = "0xff45475a";
        layout = "master";
        resize_on_border = true;
      };

      master = {
        special_scale_factor = 0.925;
        new_status = "master";
        new_on_top = true;
      };

      "$mod" = "SUPER";
      bindm = [
        # mouse movements
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];

      bind = [
        "$mod, RETURN, exec, kitty"
        "$mod, D, exec, rofi -show drun"
        "$mod SHIFT,Q,exec,killall .Hyprland-wrapp"
        "$mod, Q, killactive"

        "$mod, minus, exec, wayblur"
        
        ",XF86AudioNext,exec,playerctl next"
        ",XF86AudioPrev,exec,playerctl previous"
        ",XF86AudioStop,exec,playerctl stop"
        ",XF86AudioPlay,exec,playerctl play-pause"

        ",XF86AudioLowerVolume,exec,makofy volume_down"
        ",XF86AudioRaiseVolume,exec,makofy volume_up"
        ",XF86AudioMute,exec,makofy volume_mute"
        ",XF86AudioMicMute,exec,mictoggle"
        ",F4,exec,mictoggle"

        "$mod,XF86AudioRaiseVolume,exec,makofy brightness_up"
        "$mod,XF86AudioLowerVolume,exec,makofy brightness_down"
        ",XF86MonBrightnessUp,exec,makofy brightness_up"
        ",XF86MonBrightnessDown,exec,makofy brightness_down"

        "$mod SHIFT,M,exec,kill_decor"
        "$mod SHIFT,B,exec,kill_border"

        "$mod SHIFT,SPACE,exec,nautilus"
        ",PRINT,exec,grimshot"
        "SHIFT,PRINT,exec,grimclip"
        "$mod,PRINT,exec,grimcrop"

        "$mod,B,exec,killall -SIGUSR1 .waybar-wrapped"

        "bind=$mod,L,resizeactive,40 0"
        "$mod,H,resizeactive,-40 0"

        "$mod SHIFT,LEFT,movewindow,l"
        "$mod SHIFT,RIGHT,movewindow,r"
        "$mod SHIFT,UP,movewindow,u"
        "$mod SHIFT,DOWN,movewindow,d"
        "$mod SHIFT,H,movewindow,l"
        "$mod SHIFT,L,movewindow,r"
        "$mod SHIFT,K,movewindow,u"
        "$mod SHIFT,J,movewindow,d"

        "$mod,LEFT,movefocus,l"
        "$mod,j,movefocus,l"
        "$mod,k,movefocus,r"
        "$mod,RIGHT,movefocus,r"
        "$mod,UP,movefocus,u"
        "$mod,DOWN,movefocus,d"
        "$mod,K,movefocus,u"
        "$mod,J,movefocus,d"
        "$mod,F,togglefloating"
        "alt,space,movetoworkspace,special:base"
        "alt,P,movetoworkspace,special:term"
        "$mod,space,togglespecialworkspace,base"
        "$mod,P,togglespecialworkspace,term"
        "$mod,W,fullscreen,"
      ]
        ++ (
          builtins.concatLists (builtins.genList (i:
            let ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
            9)
        );
    };
  };
}
