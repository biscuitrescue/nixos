{ pkgs, username, ... }: {

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };

  users.users.${username}.extraGroups = [ "wireshark" ];

  environment.systemPackages = with pkgs; [
    nmap
    tcpdump
    netcat-openbsd
    masscan
    termshark

    dig.dnsutils

    burpsuite
    gobuster
    ffuf
    sqlmap

    hashcat
    john
    thc-hydra
  ];
}
