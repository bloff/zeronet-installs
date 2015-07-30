#!/bin/bash

echo \
"
Zeronet installer for Ubuntu Linux.
"

if [ "$EUID" -ne 0 ]
  then echo "Please run as root."
  exit
fi

if [ -d /opt/zeronet ]; then
    echo 'Directory /opt/zeronet already exists. Please remove it before proceeding.'
    exit
fi




# Check for dependencies

install_package() {
    PKG_NAME=$1
    PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $PKG_NAME|grep "install ok installed")
echo Checking for package $PKG_NAME: $PKG_OK
if [ "" == "$PKG_OK" ]; then
  echo "Package $PKG_NAME not found... installing..."
  apt-get --force-yes --yes install $PKG_NAME
fi

}

install_package "python"
install_package "python-msgpack"
install_package "python-gevent"



# Create zeronet user


if ! id -u zeronet > /dev/null 2>&1; then
    echo 'Creating user "zeronet".'
    adduser --home /opt/freenet/ --shell /bin/false --no-create-home --ingroup daemon --disabled-password --disabled-login zeronet
else
    echo 'User "zeronet" already exists.'
fi


# Download the files

echo 'Cloning zeronet repository into /opt/zeronet'
pushd /opt/
git clone https://github.com/HelloZeroNet/ZeroNet.git zeronet
sudo chown zeronet:zeronet zeronet
popd


# echo \
# "
# Two installation methods are available:

# systemd  -  Installs a systemd demon (Ubuntu 15.04 or later).
# script   -  Installs a script file. Startup
# "
# select yn in "systemd" "script"; do
#     case $yn in
# 	systemd)
# 	    ;;
#     esac
# done
. /etc/lsb-release

if [ "$DISTRIB_RELEASE" = "15.04" ]; then
    echo "Ubuntu 15.04 detected, installing systemd script."
    echo "To start zeronet do: "
    echo "            sudo systemctl start zeronet.service"
    cp zeronet.service /etc/systemd/system/
else
    echo "Not Ubuntu 15.04, installing zeronet script."
    echo "To start zeronet do: "
    echo "                     sudo zeronet start"
    cp zeronet /usr/local/bin
fi




echo 'Installation complete...'

echo 'Do you wish to start zeronet now?'
select yn in "Yes" "No"; do
    if [ "$yn" = "Yes" ]; then
	if [ "$DISTRIB_RELEASE" = "15.04" ]; then
	    systemctl start zeronet.service
	else
	    zeronet start
	fi
    fi
    break
done

if [ "$DISTRIB_RELEASE" = "15.04" ]; then
    echo 'Do you wish to start zeronet at boot?'
    select yn in "Yes" "No"; do
	if [ "$yn" = "Yes" ]; then
	    systemctl enable zeronet.service
	fi
	break
    done
else
    echo \
'The writer of this script knows nothing about sysv or upstart 
configurations. This means that I dont know how to configure 
Ubuntu versions prior to 15.04 to run automatic startup scripts.
I might get around to doing that myself. Otherwise, you are welcome
to update the installation script.

http://github.com/bloff/zeronet-installs/
'
    
fi
