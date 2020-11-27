#!/bin/sh
docker build -t hustcw/ctf_ubuntu_1804 - <<DOCKERFILE_EOF || exit 1
from ubuntu:18.04
run rm /etc/dpkg/dpkg.cfg.d/excludes
run sed -i 's/archive.ubuntu.com/mirrors.bfsu.edu.cn/g' /etc/apt/sources.list \
    && sed -i 's/# deb-src/deb-src/g' /etc/apt/sources.list

run dpkg --add-architecture i386 && apt update && apt full-upgrade -y && apt clean

run apt install -y locales && apt clean && \
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8
env LC_ALL en_US.UTF-8
env LANG en_US.UTF-8
env LANGUAGE en_US.UTF-8

run DEBIAN_FRONTEND=noninteractive \
    apt install -y git sudo bash make nano vim zsh tmux cmake binutils nasm gcc gdb g++ gcc-multilib g++-multilib \
    build-essential libc6-dev-i386 libc6-dbg libc6-dbg:i386 libstdc++6:i386 \
    python python-pip python3.6 python3-pip curl netcat htop iotop iftop man strace ltrace wget \
    manpages-posix manpages-posix-dev libgmp3-dev libmpfr-dev libmpc-dev python-capstone \
    nmap zmap libssl-dev inetutils-ping dnsutils whois mtr net-tools iproute2 tzdata ruby\
    && apt-get source libc6-dev \
    && apt clean

run useradd -ms /usr/bin/zsh ctf && \
    adduser ctf sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

user ctf
workdir /home/ctf
run sudo chown -R ctf:ctf /usr/local
env PATH="/home/ctf/.local/bin:\${PATH}"

run pip3 install --user -i https://pypi.tuna.tsinghua.edu.cn/simple -U pip && \
    pip2 install --user -i https://pypi.tuna.tsinghua.edu.cn/simple -U pip
run pip3 install --user -i https://pypi.tuna.tsinghua.edu.cn/simple -U ipython pycrypto pycryptodomex gmpy2 gmpy sympy numpy virtualenv requests flask angr formatstring mtp  && \
    pip3 install --user -i https://pypi.tuna.tsinghua.edu.cn/simple -U git+https://github.com/arthaud/python3-pwntools.git && \
    pip2 install --user -i https://pypi.tuna.tsinghua.edu.cn/simple -U gitdb2==2.0.6 GitPython==2.1.14 ipython pycrypto pycryptodomex gmpy2 gmpy sympy numpy virtualenv requests flask angr pwntools ropgadget

run wget https://downloads.python.org/pypy/pypy2.7-v7.3.3-linux64.tar.bz2 -P /tmp/ && \
    tar xf /tmp/pypy2.7-v7.3.3-linux64.tar.bz2 && \
    rm /tmp/pypy2.7-v7.3.3-linux64.tar.bz2 && \
    mv pypy2.7-v7.3.3-linux64 pypy2 && \
    ln -s ~/pypy2/bin/pypy /usr/local/bin/pypy && \
    pypy -m ensurepip && \
    pypy -m pip install gitdb2==2.0.6 GitPython==2.1.14 angr

run wget https://downloads.python.org/pypy/pypy3.6-v7.3.3-linux64.tar.bz2 -P /tmp/ && \
    tar xf /tmp/pypy3.6-v7.3.3-linux64.tar.bz2 && \
    rm /tmp/pypy3.6-v7.3.3-linux64.tar.bz2 && \
    mv pypy3.6-v7.3.3-linux64 pypy3 && \
    ln -s ~/pypy3/bin/pypy3 /usr/local/bin/pypy3 && \
    pypy3 -m ensurepip && \
    pypy3 -m pip install angr

run git clone https://github.com/pwndbg/pwndbg
workdir /home/ctf/pwndbg
run ./setup.sh
workdir /home/ctf

run git clone https://github.com/Ganapati/RsaCtfTool.git ~/RsaCtfTool && \
    git clone https://github.com/scwuaptx/peda.git ~/peda && cp ~/peda/.inputrc ~/ && \
    git clone https://github.com/scwuaptx/Pwngdb.git ~/Pwngdb && cat ~/Pwngdb/.gdbinit >> ~/.gdbinit && \
    sed -i 's?source ~/peda/peda.py?#source ~/peda/peda.py?g' .gdbinit && \
    sudo gem install one_gadget

run sh -c "\$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" || true && \
    curl https://raw.githubusercontent.com/zzh1996/zshrc/master/zshrc.sh > ~/.zshrc.sh && \
    sed -i '/source \\\$ZSH\/oh-my-zsh.sh/isource ~/.zshrc.sh' ~/.zshrc && \
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions && \
    git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && \
    curl https://raw.githubusercontent.com/wklken/vim-for-server/master/vimrc > ~/.vimrc

run mkdir mount
workdir /home/ctf/mount

entrypoint zsh -i
DOCKERFILE_EOF

docker run -it --rm --privileged --cap-add=SYS_PTRACE \
    --security-opt seccomp=unconfined \
    -v ${1:-$(pwd)}:/home/ctf/mount \
    --hostname ctf_docker \
    --name ctf_ubuntu_1804 \
    -e TZ=Asia/Shanghai \
    hustcw/ctf_ubuntu_1804
