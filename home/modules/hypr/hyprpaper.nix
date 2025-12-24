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
        [ "/home/karttikeya/git/wallpapers/chaos_rose.png" ];


      wallpaper = [
        "eDP-1, /home/karttikeya/git/wallpapers/chaos_rose.png"
      ]; 
    };
  };
}
