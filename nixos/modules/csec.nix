{ pkgs, username, ... }: {

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };

  users.users.${username}.extraGroups = [ "wireshark" ];

  environment.systemPackages = with pkgs; [
    nmap
    dnsrecon
    enum4linux

    tcpdump
    netcat-openbsd
    masscan
    termshark

    dig.dnsutils

    burpsuite
    nikto
    gobuster
    ffuf
    sqlmap

    metasploit
    sqlmap
    netcat
    socat
    wireshark

    hashcat
    john
    thc-hydra
    hashid
  ];
}
