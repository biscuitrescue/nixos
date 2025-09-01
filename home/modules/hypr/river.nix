{ pkgs, inputs, ... }: {
  wayland.windowManager.river = {
    enable = true;
  };
}
