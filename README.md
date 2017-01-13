# oh-my-ubuntu

### start

	# 备份安装源
	cp /etc/apt/sources.list{,.default}

	# 修改安装源
	tee /etc/apt/sources.list << EOD
	deb http://cn.archive.ubuntu.com/ubuntu/ xenial main multiverse restricted universe
	deb http://cn.archive.ubuntu.com/ubuntu/ xenial-backports main multiverse restricted universe
	deb http://cn.archive.ubuntu.com/ubuntu/ xenial-proposed main multiverse restricted universe
	deb http://cn.archive.ubuntu.com/ubuntu/ xenial-security main multiverse restricted universe
	deb http://cn.archive.ubuntu.com/ubuntu/ xenial-updates main multiverse restricted universe
	deb-src http://cn.archive.ubuntu.com/ubuntu/ xenial main multiverse restricted universe
	deb-src http://cn.archive.ubuntu.com/ubuntu/ xenial-backports main multiverse restricted universe
	deb-src http://cn.archive.ubuntu.com/ubuntu/ xenial-proposed main multiverse restricted universe
	deb-src http://cn.archive.ubuntu.com/ubuntu/ xenial-security main multiverse restricted universe
	deb-src http://cn.archive.ubuntu.com/ubuntu/ xenial-updates main multiverse restricted universe
	EOD

	# 安装 Git
	apt-get update && apt-get -yq install  language-pack-zh-hans git-core tig

* VirtualBox
