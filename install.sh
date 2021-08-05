#!/bin/bash
#!/bin/sh

if [[ $(whoami) == 'root' ]]; then
    kaliRep="deb http://http.kali.org/kali kali-rolling main non-free contrib"
    echo $kaliRep >> /etc/apt/sources.list
    apt upgrade -y
    apt install aircrack-ng nmap boxes macchanger -y 

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