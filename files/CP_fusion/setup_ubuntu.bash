#!/bin/bash
# Set up your local environment for fortran development on linux and OSX
#
# This script performs the following steps to set up your environment
#
#
# 0. Set default paths for libraries
# 1. Prompt the user for git config --user.email, --user.name
# 2. Set up git mergetool meld if present
# 3. Download ppplib and try to install it in ~/lib
# 4. Download MUMPS and try to install it in ~/lib
# 5. Create an SSH keypair if it does not exist, and print the public key
#
# Daan van Vugt <dvanvugt@ignitioncomputing.com>
# Toon Weyens <t.weyens@tue.nl>
#

# Clean envirnoment from RVM settings that may interfere with this script
unset -f cd 
export rvm_bash_nounset=1

# Some basic safety options
set -u
function log() {
  tput setaf 3;
  echo $@
  tput sgr0
}

log "Masterclass MHD setup script."
log ""
log ""

# 0. Setup colorizing and default paths
log "Setting up colors and default paths"
mkdir -p ~/local
mkdir -p ~/local/lib ~/local/include ~/local/bin
touch ~/.bashrc
if ! grep 'Masterclass bashrc settings' ~/.bashrc; then
  cat << 'EOF' >> ~/.bashrc
# Masterclass bashrc settings
alias grep="/bin/grep --color=auto"
alias ls="ls --color=auto"
alias less="less --RAW-CONTROL-CHARS"
export PATH="~/local/bin:$PATH"
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH:-}:~/local/lib:/lib
export INCLUDE_PATH=${INCLUDE_PATH:-}:~/local/include
EOF
fi

# 1. Ask for name and email address
if ! git config --global user.name >/dev/null; then
  echo ""
  log "Please enter your full name:"
  read name
  git config --global user.name "$name"
fi
if ! git config --global user.email | grep "@" >/dev/null; then
  echo ""
  log "Please enter your email address:"
  read email
  git config --global user.email "$email"
fi

# 2. git settings (mergetool etc)
log "Setting up default git settings"
log "Searching for merge tools"
if which vimdiff; then
  git config --global merge.tool vimdiff
fi
if which meld; then
  git config --global merge.tool meld
fi
if which kdiff3; then
  git config --global merge.tool kdiff3
fi
git config --global push.default matching
git config --global alias.l 'log --oneline --graph'
git config --global core.autocrlf input
git config --global color.ui auto
git config --global alias.log "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit"

# 3. Download ppplib
log "Downloading and extracting the plasma physics plotting library"
mkdir -p ~/source
cd ~/source
if [ ! -f ppplib.zip ]; then
  wget https://github.com/ToonWeyens/toonweyens.github.io/raw/refs/heads/master/files/CP_fusion/ppplib.zip
fi
ppplib_dir=ppplib
if [ ! -d "$ppplib_dir" ]; then
  mkdir -p "$ppplib_dir"
  unzip ppplib.zip -d "$ppplib_dir"
fi
cd "$ppplib_dir"
make clean
make
cp libppp20.so ~/local/lib/libppp20.so
cd ~


# 4. Download and install MUMPS
log "Downloading and installing MUMPS matrix solver"
cd ~/source
if [ ! -f MUMPS_5.8.1.tar.gz ]; then
  wget https://github.com/ToonWeyens/toonweyens.github.io/raw/refs/heads/master/files/CP_fusion/MUMPS_5.8.1.tar.gz
fi
if [ ! -d MUMPS_5.8.1 ]; then
  tar zxf MUMPS_5.8.1.tar.gz
fi
cd MUMPS_5.8.1
cp Make.inc/Makefile.inc.generic.SEQ Makefile.inc
sed -i.bak -e 's/f90/gfortran/g'  Makefile.inc
sed -i.bak 's/OPTF    = -O/OPTF    = -O2 -fallow-argument-mismatch/g' Makefile.inc
make # builds dmumps
cp lib/* ~/local/lib
cp libseq/* ~/local/lib
cp include/* ~/local/include
cd ~

# 5. Create an ssh keypair if it does not exist yet
if [ ! -f ~/.ssh/id_rsa ]; then
  ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
fi
log "Generated/found public/private key pair. Please upload the following key to gitlab.com and send us your username"
echo
cat .ssh/id_rsa.pub
echo
