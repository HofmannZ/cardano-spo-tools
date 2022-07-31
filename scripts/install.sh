#!/usr/bin/env bash
#
# Install cnvm.

#######################################
# --- GLOBALS ---
#######################################

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

#######################################
# --- UTILS ---
#######################################

#######################################
# Logs a messages in red.
# Globals:
#   RED
#   NC
# Arguments:
#   Message to log.
#######################################
echo_red() {
    echo -e "${RED}$*${NC}"
}

#######################################
# Logs a messages in green.
# Globals:
#   GREEN
#   NC
# Arguments:
#   Message to log.
#######################################
echo_green() {
    echo -e "${GREEN}$*${NC}"
}

#######################################
# Logs a messages in yellow.
# Globals:
#   YELLOW
#   NC
# Arguments:
#   Message to log.
#######################################
echo_yellow() {
    echo -e "${YELLOW}$*${NC}"
}

#######################################
# --- PROGRAM ---
#######################################

echo_green "🧰 Installing cnvm..."

echo_green "📦 Installing dependencies..."
sudo apt update && sudo apt install curl grep jq liblz4-tool sed tar unzip wget -y

echo_green "💾 Saving directory..."
currrent_dir=$(pwd)

echo_green "📂 Cloning repository..."
cd "${HOME}/git" || exit 1
git clone https://github.com/HofmannZ/cardano-spo-tools.git

echo_green "📋 Appending config to .adaenv..."
echo "
# config for https://github.com/HofmannZ/cardano-spo-tools
export GIT_HOME=\"\${HOME}/git\"
export CARDANO_SPO_TOOLS=\"\${GIT_HOME}/cardano-spo-tools\"

cnvm() {
  \"\${CARDANO_SPO_TOOLS}/scripts/cnvm.sh\" \"\$@\"
}

export -f cnvm

source \"\${CARDANO_SPO_TOOLS}/bash/aliases.sh\"
" >>"${HOME}/.adaenv"

echo_green "📡 Sourcing .adaenv..."
source "${HOME}/.adaenv"

echo_green "✅ Restoring directory..."
cd "${currrent_dir}" || exit 1

echo_green "✅ All done!"
