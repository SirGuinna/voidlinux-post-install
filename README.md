<p align="center">
<img width="700px" src="https://github.com/SirGuinna/voidlinux-post-install/blob/main/img/void-img.jpg" align="center" alt="white" /><br><br>
  
<img alt="Maintained" src="https://img.shields.io/badge/Maintained%3F-Yes-green">
<img alt="GitHub Last Commit" src="https://img.shields.io/github/last-commit/SirGuinna/voidlinux-post-install">
</p>

# AVISO

Ao usar este roteiro você assume que entende os riscos e assume total responsabilidade por suas ações. Não há nenhuma garantia implícita ou explícita do seu funcionamento. O intuito é facilitar a instalação, resolvi deixar mais completo caso alguem queira aprender ou usar de forma manual. Se ele te ajudar deixe uma Estrela.

# Objetivos

Neste roteiro considero que estamos partindo de uma instalação BASE do **VOID LINUX**. Esse roteiro funciona como um guia passo a passo para ajudar na **PÓS-INSTALAÇÃO** e configuração usando o I3WM como interface gráfica.
<br>
O objetivo deste roteiro **não é ser um script totalmente automatizado**, apesar de no fim desse documento ter um Script para automatizar esse processo caso queira utilizar.
<br>
A seleção de pacotes escolhidos, foi feita para atender instalações em DESKTOPs e NOTEBOOKs, então remova ou adicione pacotes de acordo com sua necessidade e escolha. **NO FIM DESSE DOCUMENTO TEM UM SCRIPT PARA AUTOMATIZAR TODO ESSE PROCESSO**.

# 1º - Preparação

## 1.1 Conectando na Internet
WIFI CONNECTION
```shellscript
sudo ip link set wlo1 up
```
```shellscript
wpa_passphrase "SSID" "password" | sudo tee /etc/wpa_supplicant.conf
```
```shellscript
sudo wpa_supplicant -B -i wlo1 -c /etc/wpa_supplicant.conf
```
```shellscript
sudo dhclient wlo1
```

---

ETHERNET CONNECTION
```shellscript
ip link
```
```shellscript
sudo ip link set YOUR_CONNECTION up
```
```shellscript
sudo dhclient YOUR_CONNECTION
```

## 1.2 Atualizando Sistema
```shellscript
sudo xbps-install -Syu
```

## 1.3 Instalando Pacotes Essenciais
```shellscript
sudo xbps-install -S git xorg lightdm i3 xfce4-terminal nano xed rofi firefox sysstat i3blocks curl lxappearance nitrogen lxqt-policykit xfce4-power-manager lightdm-webkit2-greeter psmisc xdotool volumeicon notify-osd pavucontrol which mpv htop thunar fastfetch w3m acpid fish arandr networkmanager elogind picom font-awesome noto-fonts-emoji
```

## 1.4 Instalando Suporte a Flatpak (Opcional)
```shellscript
sudo xbps-install -S flatpak
```
```shellscript
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
```

# 2º - Personalização do Ambiente I3WM

## 2.1 Copiando Configurações Prontas (Opcional)
```shellscript
git clone https://github.com/SirGuinna/voidlinux-post-install;cd voidlinux-post-install
```
```shellscript
mkdir -p $HOME/.config
```
```shellscript
cp -vf ./compton.conf $HOME/.config/
```
```shellscript
cp -vf ./picom.conf $HOME/.config/
```
```shellscript
fc-cache -fv
```
```shellscript
cp -vf ./.i3blocks.conf $HOME/
```
```shellscript
cp -rvf ./i3 $HOME/.config/
```
```shellscript
sudo cp -rvf ./rofi-themes/* /usr/share/rofi/themes/
```

## 2.2 Instalando Fish Shell (Opcional)
```shellscript
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
```

## 2.3 Recarrega i3 para aplicar mudanças
```shellscript
sudo i3-msg reload > /dev/null
```

## 2.4 Ativando inicialização de serviços junto com o sistema
```shellscript
sudo ln -sf /etc/sv/networkmanager /var/service
```
```shellscript
sudo ln -sf /etc/sv/dbus /var/service
```
```shellscript
sudo ln -sf /etc/sv/elogind /var/service
```
```shellscript
sudo ln -sf /etc/sv/acpid /var/service
```
```shellscript
sudo ln -sf /etc/sv/lightdm /var/service
```


---


## Script de Instalação Automática
```shellscript
git clone https://github.com/SirGuinna/voidlinux-post-install
```
```shellscript
cd voidlinux-post-install
```
```shellscript
chmod +x void-installer.sh
```
```shellscript
./void-installer.sh
```

## Use o theme-selector.py para escolher um tema predefinido
```shellscript
cd voidlinux-post-install
```
```shellscript
theme-selector.py
```
