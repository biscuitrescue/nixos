{ pkgs, username, ... }: {
  users.users.${username} = {
    isNormalUser = true;
    description = "Karttikeya Sinha";
    extraGroups = [
      "wheel"
      "audio"
      "input"
      "video"
      "networkmanager"
      "lp"
      "scanner"
      "kvm"
      "libvirtd"
    ];
    shell = pkgs.zsh;
  };
}
