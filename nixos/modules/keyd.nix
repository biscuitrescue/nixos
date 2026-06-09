{ ... }:
{
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings.main = {
        capslock = "overload(control, esc)";
        insert    = "home";

        # Home-row mods (left)
        a = "lettermod(shift,   a, 150, 200)";
        s = "lettermod(alt,     s, 150, 200)";
        d = "lettermod(meta,    d, 150, 200)";
        f = "lettermod(control, f, 150, 200)";

        # Home-row mods (right)
        h = "lettermod(control, h, 150, 200)";
        j = "lettermod(meta,    j, 150, 200)";
        k = "lettermod(alt,     k, 150, 200)";
        l = "lettermod(shift,   l, 150, 200)";
      };
    };
  };
}
