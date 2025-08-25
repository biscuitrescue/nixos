{config, lib, pkgs, ...}: let user = "cafo"; in {
  users.users.${user}= {
    isNormalUser = true;
    description = "Karttikeya Sinha";
    extraGroups = [ "wheel" "audio" "input" "video" "networkmanager" "lp" "scanner" "kvm" "libvirtd" "vbox"];
    shell = pkgs.fish;
  };

}
