#!/bin/bash

CONFIG_DIR="$HOME/.config"
ROFI_DIR="/usr/share/rofi/themes"

# Verifica se o script está sendo executado com permissões de root
if [ "$(id -u)" -ne 0 ]; then
    echo "Este script precisa ser executado como ROOT."
    echo "This script needs to be run as ROOT."
    exit 1
fi

# Habilita o modo de falha imediata (interrompe o script se qualquer comando falhar)
set -e

# Verifica a conexão com a Internet
verificar_conexao() {
    echo "Checking Internet Connection..."
    if ping -q -c 1 -W 1 google.com >/dev/null; then
        echo "Internet Connection Verified."
    else
        echo "ERROR: Sem conexão com a internet. Conecte-se e tente novamente."
        echo "ERROR: No internet connection. Connect and try again."
        echo "X"
        echo "# # # # # # # # # # # # # # WIFI CONNECTION # # # # # # # # # # # # # # #"
        echo "#                       sudo ip link set wlo1 up                        #"
        echo "#  wpa_passphrase "SSID" "PASSWORD" | sudo tee /etc/wpa_supplicant.conf #"
        echo "#       sudo wpa_supplicant -B -i wlo1 -c /etc/wpa_supplicant.conf      #"
        echo "#                          sudo dhclient wlo1                           #"
        echo "# # # # # # # # # # # # # # # # # # ! # # # # # # # # # # # # # # # # # #"
        echo "                                                                         "
        echo "# # # # # # # # # # # # # ETHERNET CONNECTION # # # # # # # # # # # # # #"
        echo "#                              ip link                                  #"
        echo "#                  sudo ip link set YOUR_CONNECTION up                  #"
        echo "#                     sudo dhclient YOUR_CONNECTION                     #"
        echo "# # # # # # # # # # # # # # # # # # ! # # # # # # # # # # # # # # # # # #"
        while true; do
            read -p "Press Enter to try again or Ctrl+C to exit..."
            if ping -q -c 1 -W 1 google.com >/dev/null; then
                echo "Internet Connection Verified."
                break
            else
                echo "No connection. Please try again."
            fi
        done
    fi
}

# Atualização completa do sistema
atualizar_sistema() {
    echo "The system will update, it will take a few minutes..."
    sudo xbps-install -Syu
    echo "System updated successfully!"
}

# Funcao para instalar o Flatpak e adicionar o repositorio Flathub
instalar_flatpak_e_adicionar_flathub() {
    # Verifica e instala o Flatpak
    if ! command -v flatpak &> /dev/null; then
        echo "Flatpak is not installed. Installing Flatpak..."
        sudo xbps-install -y flatpak
    fi
    # Verifica e adiciona o repositorio Flathub se ainda nao estiver adicionado
    if ! flatpak remote-list | grep -q flathub; then
        echo "Adding Flathub repository..."
        flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    else
        echo "Flathub repository already added."
    fi
}

# Instalação dos pacotes necessários
instalar_pacotes() {
    echo "Starting to install packages will take a few minutes..."
    sudo xbps-install -y git \
        xorg \
        lightdm \
        i3 \
        xfce4-terminal \
        nano \
        xed \
        rofi \
        firefox \
        sysstat \
        i3blocks \
        curl \
        lxappearance \
        nitrogen \
        lxqt-policykit \
        xfce4-power-manager \
        lightdm-webkit2-greeter \
        psmisc \
        xdotool \
        volumeicon \
        notify-osd \
        pavucontrol \
        which \
        mpv \
        htop \
        thunar \
        fastfetch \
        w3m \
        acpid \
        fish \
        arandr \
        networkmanager \
        elogind \
        picom \
        font-awesome \
        noto-fonts-emoji
    echo "Additional packages installed successfully!"
}

# Copia configurações personalizadas, substituindo arquivos existentes caso tenha
copiar_configs() {
    echo "Copying configuration files..."
    
    mkdir -p "$CONFIG_DIR"
    cp -vf ./compton.conf "$CONFIG_DIR/"
    cp -vf ./picom.conf "$CONFIG_DIR/"

    # Copia configuração do i3blocks e temas do rofi, substituindo arquivos existentes caso tenha
    cp -vf ./.i3blocks.conf "$HOME/"
    cp -rvf ./i3 "$CONFIG_DIR/"
    cp -rvf ./rofi-themes/* "$ROFI_DIR/"

    # Atualiza cache de fontes
    fc-cache -fv

    # Recarrega o i3 para aplicar mudanças
    sudo i3-msg reload > /dev/null
    
    echo "Copies made successfully!"
}

# Instalação do Oh-My-Fish para o Fish Shell
instalar_fish_shell() {
    echo "Installing Fish Shell..."
    curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
    echo "Instalation Fish Shell made successfully!"
}

# Ativa serviços essenciais
ativar_servicos() {
    echo "Configuring essential services to start along with the system..."
    sudo ln -sf /etc/sv/networkmanager /var/service
    sudo ln -sf /etc/sv/dbus /var/service
    sudo ln -sf /etc/sv/lightdm /var/service
    sudo ln -sf /etc/sv/elogind /var/service
    sudo ln -sf /etc/sv/acpid /var/service
    echo "Essential services successfully configured!"
}

## ICONES para i3blocks -> https://fontawesome.com/v5/cheatsheet
## Alternativas para notificação pesquisar -> notification-daemon

#####################################################################################################

# Inicio do processo
echo "Starting the installation process..."

# Chamando as funções
verificar_conexao
atualizar_sistema
instalar_flatpak_e_adicionar_flathub
instalar_pacotes
copiar_configs
instalar_fish_shell
ativar_servicos
