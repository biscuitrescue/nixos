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
        s = "lettermod(alt,     s, 150, 200)";
        d = "lettermod(meta,    d, 150, 200)";

        # Home-row mods (right)
        j = "lettermod(meta,    j, 150, 200)";
        k = "lettermod(alt,     k, 150, 200)";
      };
    };
  };
}
