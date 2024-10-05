#!/bin/bash

# Verifica se Git e Curl estão instalados
if ! command -v git &> /dev/null; then
    echo "Git não está instalado. Por favor, instale o Git e execute o script novamente."
    exit 1
fi

if ! command -v curl &> /dev/null; then
    echo "Curl não está instalado. Por favor, instale o Curl e execute o script novamente."
    exit 1
fi

# Instalação do Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Instalando Oh My Zsh..."
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Oh My Zsh já está instalado."
fi

# Plugins: zsh-autosuggestions, zsh-syntax-highlighting, fast-syntax-highlighting, zsh-autocomplete
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

echo "Instalando plugins..."

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
fi

if [ ! -d "$ZSH_CUSTOM/plugins/fast-syntax-highlighting" ]; then
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git $ZSH_CUSTOM/plugins/fast-syntax-highlighting
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autocomplete" ]; then
    git clone https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete
fi

# Copiando o .zshrc personalizado para o diretório do usuário
if [ -f "$HOME/.zshrc" ]; then
    echo "Fazendo backup do .zshrc existente..."
    mv $HOME/.zshrc $HOME/.zshrc.backup
fi
echo "Copiando .zshrc personalizado..."
cp .zshrc $HOME/.zshrc

# Mensagem para o usuário
echo "Por favor, abra um novo terminal para que as configurações sejam aplicadas."
echo "Configuração concluída!"
