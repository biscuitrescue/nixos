{
  ...
}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;

      preload =
        [ "/home/cafo/git/wallpapers/beachhouses.png" ];


      wallpaper = [
        "eDP-1, /home/cafo/git/wallpapers/beachhouses.png"
      ]; 
    };
  };
}
