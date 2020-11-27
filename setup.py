import os

os.system("sudo sed -i 's/archive.ubuntu.com/mirrors.bfsu.edu.cn/g' /etc/apt/sources.list \
    && sudo sed -i 's/# deb-src/deb-src/g' /etc/apt/sources.list")
print("[*] apt source changed")
os.system("sudo dpkg --add-architecture i386 && sudo apt update && sudo apt full-upgrade -y && sudo apt clean")

os.system("sudo apt install -y locales && sudo apt clean && \
    sudo sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    sudo dpkg-reconfigure --frontend=noninteractive locales && \
    sudo update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8")

print("[*] language setting done")
os.system("sudo apt install -y git sudo bash make nano vim zsh tmux cmake binutils nasm gcc gdb g++ gcc-multilib \
    build-essential libc6-dev-i386 libc6-dbg libc6-dbg:i386 \
    python python-pip python3 python3-pip curl netcat htop iotop iftop man strace ltrace wget \
    manpages-posix manpages-posix-dev libgmp3-dev libmpfr-dev libmpc-dev \
    nmap zmap libssl-dev inetutils-ping dnsutils whois mtr net-tools iproute2 tzdata ruby \
    ssh \
    && sudo apt-get source libc6-dev \
    && sudo apt clean")
print("[*] useful apt tools downloaded")
os.system("pip3 install -i https://pypi.tuna.tsinghua.edu.cn/simple --user --no-cache-dir -U pip && \
        pip2 install -i https://pypi.tuna.tsinghua.edu.cn/simple --user --no-cache-dir -U pip && \
        pip3 install -i https://pypi.tuna.tsinghua.edu.cn/simple --user --no-cache-dir -U jupyterlab ipython pycrypto pycryptodomex gmpy2 gmpy sympy numpy virtualenv requests flask formatstring mtp capstone  && \
    pip3 install --user --no-cache-dir -U git+https://github.com/arthaud/python3-pwntools.git && \
    pip2 install -i https://pypi.tuna.tsinghua.edu.cn/simple --user --no-cache-dir -U jupyterlab ipython pycrypto pycryptodomex gmpy2 gmpy sympy numpy virtualenv requests flask pwntools ropgadget capstone")
print("[*] useful python2/3 tools downloaded")
os.system("git clone https://github.com/pwndbg/pwndbg && cd pwndbg && ./setup.sh && cd .. && \
    git clone https://github.com/Ganapati/RsaCtfTool.git ~/RsaCtfTool && \
    git clone https://github.com/scwuaptx/peda.git ~/peda && cp ~/peda/.inputrc ~/ && \
    git clone https://github.com/scwuaptx/Pwngdb.git ~/Pwngdb && cat ~/Pwngdb/.gdbinit >> ~/.gdbinit && \
    sed -i 's?source ~/peda/peda.py?#source ~/peda/peda.py?g' .gdbinit && \
    sudo rm -rf ~/.cache/pip && \
    sudo gem install one_gadget")
print("[*] useful pwn and rsa tools downloaded")

os.system("sh -c \"$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)\" || true && \
    curl https://raw.githubusercontent.com/Hustcw/ctf-docker/master/zshrc > ~/.zshrc && \
    curl https://raw.githubusercontent.com/Hustcw/ctf-docker/master/tmux.conf > ~/.tmux.conf && \
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions && \
    git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && \
    curl https://raw.githubusercontent.com/wklken/vim-for-server/master/vimrc > ~/.vimrc")
print("[*] shell setup done")
