#!/bin/bash
#!/bin/sh

if [[ $(whoami) == 'root' ]]; then
    kaliRep='deb https://http.kali.org/kali kali-rolling main non-free contrib'
    kaliGPG='https://archive.kali.org/archive-key.asc'
    sh -c "echo $kaliRep > /etc/apt/sources.list.d/kali.list"
    apt install gnupg -y
    wget $kaliGPG
    apt-key add archive-key.asc
    apt update -y
    apt install aircrack-ng nmap boxes macchanger tmux -y 
    chmod +x dscrack.sh 


    echo "D-SCRIPTCRACK - was installed" | boxes -d stone
    echo "dxv1d@tuta.io | webgtx @ 2021" | boxes -d stone
    echo ""
    echo "Then you can run dscrack.sh"
else
    echo
    echo
    echo "  !!! WARNING YOU NEED RUN THIS SCRIPT AS ROOT !!!"
    echo
    echo
fi