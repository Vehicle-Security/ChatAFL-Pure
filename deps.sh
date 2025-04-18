
apt-get -y update
apt-get -y install sudo \
	apt-utils \
	build-essential \
	openssl \
	clang \
	graphviz-dev \
	git \
	autoconf \
	libgnutls28-dev \
	libssl-dev \
	llvm \
	python3-pip \
	nano \
	net-tools \
	vim \
	gdb \
	netcat \
	strace \
	wget \
	bear

pip3 install gcovr==4.2

# # Add clang-12 alternative
# apt install clang-12 
# update-alternatives --install /usr/bin/clang clang /usr/bin/clang-12 60
# update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-12 60
# update-alternatives --install /usr/bin/llvm-config llvm-config /usr/bin/llvm-config-12 60