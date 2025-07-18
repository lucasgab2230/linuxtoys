#!/bin/bash
# functions

# updater
current_ltver="3.1"
ver_upd () {
    local ver
    ver=$(curl -s https://raw.githubusercontent.com/psygreg/linuxtoys/refs/heads/main/src/ver)
    if [[ "$ver" != "$current_ltver" ]]; then
        if whiptail --title "$msg001" --yesno "$msg002" 8 78; then
            local title="$msg001"
            local msg="$msg157"
            _msgbox_
            xdg-open https://github.com/psygreg/linuxtoys/releases/latest         
        fi
    fi
}

# kernel update checker for debian/ubuntu
krn_chk () {

    if [[ "$ID_LIKE" == *debian* ]] || [[ "$ID_LIKE" == *ubuntu* ]] || [ "$ID" == "debian" ] || [ "$ID" == "ubuntu" ]; then
        if [ -f "$HOME/.local/kernelsetting" ]; then
        source $HOME/.local/kernelsetting
            if [ "$_psygreg_krn" == "yes" ]; then
                local _kversion=$(curl -s https://raw.githubusercontent.com/psygreg/linuxtoys/refs/heads/main/src/psy-krn)
                if [ $(uname -r) != "${_kversion}-psycachy" ] && [ $(uname -r) != "${_kversion}-cachyos" ]; then
                    if whiptail --title "$msg126" --yesno "$msg127" 8 78; then
                        if ! diff -q "$HOME/.local/kernelsetting" <(curl -s https://raw.githubusercontent.com/psygreg/linuxtoys/refs/heads/main/src/kernelsetting-defaults) > /dev/null; then
                            bash <(curl -s https://raw.githubusercontent.com/psygreg/linux-cachyos-deb/refs/heads/master/src/cachyos-deb.sh) -s
                        else
                            psycachy_lib
                            # update systemd settings
                            cachyos_sysd_lib
                        fi
                        # clean old kernels
                        dpkg --list | grep -v $(uname -r) | grep -E 'linux-image-[0-9]|linux-headers-[0-9]' | awk '{print $2" "$3}' | sort -k2,2 | head -n -2 | awk '{print $1}' | xargs sudo apt purge
                        dpkg --list | grep -v $(uname -r) | grep -E 'custom-kernel-[0-9]|custom-kernel-headers-[0-9]' | awk '{print $2" "$3}' | sort -k2,2 | head -n -2 | awk '{print $1}' | xargs sudo apt purge
                    fi
                fi
            fi
        fi
    fi

}

# runtime
# check internet connection
# ping google
. /etc/os-release
wget -q -O - "https://raw.githubusercontent.com/psygreg/linuxtoys/refs/heads/main/README.md" > /dev/null || { whiptail --title "Disconnected" --msgbox "LinuxToys requires an internet connection to proceed." 8 78; exit 1; }
# call linuxtoys turbobash lib
source <(curl -s https://raw.githubusercontent.com/psygreg/linuxtoys/refs/heads/main/src/linuxtoys.lib)
# logger
logfile="$HOME/.local/linuxtoys-log.txt"
_log_
# language and upd checks
_lang_
source <(curl -s https://raw.githubusercontent.com/psygreg/linuxtoys/refs/heads/main/src/lang/${langfile})
ver_upd
krn_chk

# main menu
while :; do

    CHOICE=$(whiptail --title "LinuxToys" --menu "LinuxToys ${current_ltver}" 25 78 16 \
        "0" "$msg120" \
        "1" "$msg121" \
        "2" "$msg122" \
        "3" "$msg123" \
        "4" "$msg143" \
        "5" "$msg199" \
        "6" "$msg227" \
        "" "" \
        "" "" \
        "7" "$msg124" \
        "8" "GitHub" \
        "9" "$msg059" 3>&1 1>&2 2>&3)

    exitstatus=$?
    if [ $exitstatus != 0 ]; then
        # Exit the script if the user presses Esc
        find "$HOME" -maxdepth 1 -type f -name '*supermenu.sh' -exec rm -f {} + && break
    fi

    case $CHOICE in
    0) supmenu="usupermenu" && _invoke_ ;;
    1) supmenu="osupermenu" && _invoke_ ;;
    2) supmenu="gsupermenu" && _invoke_ ;;
    3) supmenu="esupermenu" && _invoke_ ;;
    4) supmenu="dsupermenu" && _invoke_ ;;
    5) supmenu="csupermenu" && _invoke_ ;;
    6) subscript="pdefaults" && _invoke_ ;;
    7) whiptail --title "LinuxToys v${current_ltver}" --msgbox "$msg125" 8 78 ;;
    8) xdg-open https://github.com/psygreg/linuxtoys ;;
    9 | q) break ;;
    *) echo "Invalid Option" ;;
    esac
done
