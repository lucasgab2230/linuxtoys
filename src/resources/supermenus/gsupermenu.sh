#!/bin/bash

# initialize variables for reboot status
flatpak_run=""
sboost_run=""
dsplitm_run=""
# supermenu checklist
gsupermenu () {

    local steam_status=$([ "$_steam" = "steam" ] && echo "ON" || echo "OFF")
    local lutris_status=$([ "$_lutris" = "net.lutris.Lutris" ] && echo "ON" || echo "OFF")
    local heroic_status=$([ "$_heroic" = "com.heroicgameslauncher.hgl" ] && echo "ON" || echo "OFF")
    local pp_status=$([ "$_pp" = "com.vysp3r.ProtonPlus" ] && echo "ON" || echo "OFF")
    local stl_status=$([ "$_stl" = "com.valvesoftware.Steam.Utility.steamtinkerlaunch" ] && echo "ON" || echo "OFF")
    local sober_status=$([ "$_sobst" = "org.vinegarhq.Sober" ] && echo "ON" || echo "OFF")
    local disc_status=$([ "$_disc" = "com.discordapp.Discord" ] && echo "ON" || echo "OFF")
    local gmode_status=$([ "$_gmode" = "gamemode" ] && echo "ON" || echo "OFF")
    local gscope_status=$([ "$_gscope" = "gamescope" ] && echo "ON" || echo "OFF")
    local mhud_status=$([ "$_mhud" = "mangohud" ] && echo "ON" || echo "OFF")
    local govl_status=$([ "$_govl" = "goverlay" ] && echo "ON" || echo "OFF")
    local sboost_status=$([ "$_sboost" = "yes" ] && echo "ON" || echo "OFF")
    local dsplitm_status=$([ "$_dsplitm" = "yes" ] && echo "ON" || echo "OFF")
    local wivrn_status=$([ "$_wivrn" = "io.github.wivrn.wivrn" ] && echo "ON" || echo "OFF")
    local steer_status=$([ "$_steer" = "io.github.berarma.Oversteer" ] && echo "ON" || echo "OFF")
    local gfn_status=$([ "$_gfn" = "yes" ] && echo "ON" || echo "OFF")
    local mcbe_status=$([ "$_mcbe" = "io.mrarm.mcpelauncher" ] && echo "ON" || echo "OFF")
    local runner_status=$([ "$_runner" = "runners" ] && echo "ON" || echo "OFF")
    local nexmod_status=$([ "$_nexmod" = "yes" ] && echo "ON" || echo "OFF")
    local osuf_status=$([ "$_osuf" = "sh.ppy.osu" ] && echo "ON" || echo "OFF")

    while :; do

        local selection
        selection=$(whiptail --title "$msg131" --checklist \
            "$msg131" 20 78 15 \
            "Steam" "$msg109" $steam_status \
            "Lutris" "$msg110" $lutris_status \
            "Heroic Games Launcher" "$msg111" $heroic_status \
            "ProtonPlus" "$msg112" $pp_status \
            "SteamTinkerLaunch" "$msg113" $stl_status \
            "NexusMods" "$msg189" $nexmod_status \
            "Sober" "$msg114" $sober_status \
            "Osu!" "$msg221" $osuf_status \
            "Bedrock Launcher" "$msg160" $mcbe_status \
            "Discord" "$msg130" $disc_status \
            "Gamemode" "$msg115" $gmode_status \
            "Gamescope" "$msg116" $gscope_status \
            "Mangohud" "$msg117" $mhud_status \
            "GOverlay" "$msg118" $govl_status \
            "GeForce NOW" "$msg152" $gfn_status \
            "Shader Booster" "$msg119" $sboost_status \
            "Disable SLM" "$msg041" $dsplitm_status \
            "Oversteer" "$msg145" $steer_status \
            "WiVRn" "$msg144" $wivrn_status \
            "Wine" "$msg156" $runner_status \
            3>&1 1>&2 2>&3)

        exitstatus=$?
        if [ $exitstatus != 0 ]; then
        # Exit the script if the user presses Esc
            break
        fi

        [[ "$selection" == *"Steam"* ]] && _steam="steam" || _steam=""
        [[ "$selection" == *"Lutris"* ]] && _lutris="net.lutris.Lutris" || _lutris=""
        [[ "$selection" == *"Heroic Games Launcher"* ]] && _heroic="com.heroicgameslauncher.hgl" || _heroic=""
        [[ "$selection" == *"ProtonPlus"* ]] && _pp="com.vysp3r.ProtonPlus" || _pp=""
        [[ "$selection" == *"SteamTinkerLaunch"* ]] && _stl="com.valvesoftware.Steam.Utility.steamtinkerlaunch" || _stl=""
        [[ "$selection" == *"Sober"* ]] && _sobst="org.vinegarhq.Sober" || _sobst=""
        [[ "$selection" == *"Osu!"* ]] && _osuf="sh.ppy.osu" || _osuf=""
        [[ "$selection" == *"Bedrock Launcher"* ]] && _mcbe="io.mrarm.mcpelauncher" || _mcbe=""
        [[ "$selection" == *"Discord"* ]] && _disc="com.discordapp.Discord" || _gmode=""
        [[ "$selection" == *"Gamemode"* ]] && _gmode="gamemode" || _gmode=""
        [[ "$selection" == *"Gamescope"* ]] && _gscope="gamescope" || _gscope=""
        [[ "$selection" == *"Mangohud"* ]] && _mhud="mangohud" || _mhud=""
        [[ "$selection" == *"GOverlay"* ]] && _govl="goverlay" || _govl=""
        [[ "$selection" == *"Shader Booster"* ]] && _sboost="yes" || _sboost=""
        [[ "$selection" == *"Disable SLM"* ]] && _dsplitm="yes" || _dsplitm=""
        [[ "$selection" == *"WiVRn"* ]] && _wivrn="io.github.wivrn.wivrn" || _wivrn=""
        [[ "$selection" == *"Oversteer"* ]] && _steer="io.github.berarma.Oversteer" || _steer=""
        [[ "$selection" == *"GeForce NOW"* ]] && _gfn="yes" || _gfn=""
        [[ "$selection" == *"Wine"* ]] && _runner="runners" || _runner=""
        [[ "$selection" == *"NexusMods"* ]] && _nexmod="yes" || _nexmod=""

        install_flatpak
        install_native
        if [[ -n "$_sboost" ]]; then
            sboost_lib
        fi
        if [[ -n "$_dsplitm" ]]; then
            dsplitm_lib
        fi
        runners_t
        nexusmods_t
        if [[ -n "$flatpak_run" || -n "$dsplitm_run" || -n "$sboost_run" ]]; then
            local title="$msg006"
            local msg="$msg036"
            _msgbox_
        else
            local title="$msg006"
            local msg="$msg018"
            _msgbox_
        fi
        break
    
    done

}

# installer functions
# native packages
install_native () {

    local _packages=($_steam $_gmode $_govl $_gscope $_mhud)
    if [[ -n "$_packages" ]]; then
        if [[ "$ID_LIKE" == *debian* ]] || [[ "$ID_LIKE" == *ubuntu* ]] || [ "$ID" == "debian" ] || [ "$ID" == "ubuntu" ]; then
            if [[ -n "$_steam" ]]; then
                cd $HOME
                wget https://cdn.fastly.steamstatic.com/client/installer/steam.deb
                sudo apt install ./steam.deb
                rm steam.deb
            fi
        fi
        if [[ -n "$_gscope" ]]; then
            if command -v flatpak &> /dev/null; then
                flatpak install --or-update --system -y org.freedesktop.Platform.VulkanLayer.gamescope/x86_64/23.08
            fi
        fi
        if [[ -n "$_mhud" ]]; then
            if command -v flatpak &> /dev/null; then
                flatpak install --or-update --system -y org.freedesktop.Platform.VulkanLayer.MangoHud
            fi
        fi
    fi
    _install_

}

# flatpak packages
install_flatpak () {

    local _flatpaks=($_lutris $_heroic $_pp $_stl $_sobst $_disc $_wivrn $_steer $_mcbe $_osuf)
    if [[ -n "$_flatpaks" ]] || [[ -n "$_steam" ]] || [[ -n "$_gfn" ]]; then
        if command -v flatpak &> /dev/null; then
            flatpak_in_lib
            _flatpak_
            if [[ -n "$_steam" ]]; then
                flatpak install --or-update -u -y com.valvesoftware.Steam
                sleep 1
                sed -i 's/^Name=Steam$/Name=Steam (Flatpak)/' "$HOME/.local/share/applications/com.valvesoftware.Steam.desktop"
            fi
            if [[ -n "$_gfn" ]]; then
                flatpak remote-add --user --if-not-exists GeForceNOW
                flatpak install -y --user GeForceNOW com.nvidia.geforcenow
            fi
            if [[ -n "$_steer" ]]; then
                sudo wget https://github.com/berarma/oversteer/raw/refs/heads/master/data/udev/99-fanatec-wheel-perms.rules -P /etc/udev/rules.d
                sudo wget https://github.com/berarma/oversteer/raw/refs/heads/master/data/udev/99-logitech-wheel-perms.rules -P /etc/udev/rules.d
                sudo wget https://github.com/berarma/oversteer/raw/refs/heads/master/data/udev/99-thrustmaster-wheel-perms.rules -P /etc/udev/rules.d
                local title="Oversteer"
                local msg="$msg146"
                _msgbox_
                xdg-open https://github.com/berarma/oversteer?tab=readme-ov-file#supported-devices
            fi
            if [[ -n "$_mcbe" ]]; then
                local title="Bedrock Launcher"
                local msg="$msg161"
                _msgbox_
            fi
        else
            if whiptail --title "$msg006" --yesno "$msg085" 8 78; then
                flatpak_run="1"
                flatpak_in_lib
                _flatpak_
                if [[ -n "$_steam" ]]; then
                    flatpak install --or-update -u -y com.valvesoftware.Steam
                    sed -i 's/^Name=Steam$/Name=Steam (Flatpak)/' "$HOME/.local/share/applications/com.valvesoftware.Steam.desktop"
                fi
                if [[ -n "$_gfn" ]]; then
                    flatpak remote-add --user --if-not-exists GeForceNOW
                    flatpak install -y --user GeForceNOW com.nvidia.geforcenow
                fi
                if [[ -n "$_steer" ]]; then
                    sudo wget https://github.com/berarma/oversteer/raw/refs/heads/master/data/udev/99-fanatec-wheel-perms.rules -P /etc/udev/rules.d
                    sudo wget https://github.com/berarma/oversteer/raw/refs/heads/master/data/udev/99-logitech-wheel-perms.rules -P /etc/udev/rules.d
                    sudo wget https://github.com/berarma/oversteer/raw/refs/heads/master/data/udev/99-thrustmaster-wheel-perms.rules -P /etc/udev/rules.d
                    local title="Oversteer"
                    local msg="$msg146"
                    _msgbox_
                    xdg-open https://github.com/berarma/oversteer?tab=readme-ov-file#supported-devices
                fi
                if [[ -n "$_mcbe" ]]; then
                    local title="Bedrock Launcher"
                    local msg="$msg161"
                    _msgbox_
                fi
            else
                local title="$msg030"
                local msg="$msg132"
                _msgbox_
            fi
        fi
    fi

}

# custom runners
runners_t () {

    if [[ -n "$_runner" ]]; then
        local subscript="$_runner"
        _invoke_
    fi

}

nexusmods_t () {

    if [[ -n "$_nexmod" ]]; then
        local ver=$(curl -s "https://api.github.com/repos/Nexus-Mods/NexusMods.App/releases/latest" | grep -oP '"tag_name": "\K(.*)(?=")')
        cd $HOME
        insta fuse3
        wget https://github.com/Nexus-Mods/NexusMods.App/releases/download/${ver}/NexusMods.App.x86_64.AppImage
        ./NexusMods.App.x86_64.AppImage --appimage-extract
        cd squashfs-root
        mkdir -p nexusmods
        if [ -d /usr/bin/nexusmods ]; then
            cp -rf usr/bin/ nexusmods
            sudo rm -rf /usr/bin/nexusmods
            sudo cp -r nexusmods /usr/bin
        else
            cp -rf usr/bin/ nexusmods
            sudo cp -r nexusmods /usr/bin
            sudo cp -r usr/share/applications/ /usr/share/applications/
            sudo cp -r usr/share/icons/hicolor/scalable/apps/ /usr/share/icons/hicolor/scalable/apps/
            sudo cp -r usr/share/metainfo/ /usr/share/metainfo/
            sudo sed -i 's|^Exec=/usr/bin/NexusMods.App %u$|Exec=/usr/bin/nexusmods/NexusMods.App %u|' "/usr/share/applications/com.nexusmods.app.desktop"
        fi
        cd ..
        sleep 1
        rm -rf squashfs-root
        rm NexusMods.App.x86_64.AppImage
    fi

}

# runtime
. /etc/os-release
source <(curl -s https://raw.githubusercontent.com/psygreg/linuxtoys/refs/heads/main/src/linuxtoys.lib)
_lang_
source <(curl -s https://raw.githubusercontent.com/psygreg/linuxtoys/refs/heads/main/src/lang/${langfile})
gsupermenu