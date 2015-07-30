# zeronet-installs
Software for installing zeronet.

Currently we have an installer for Ubuntu, and nothing else.
On Ubuntu 15.04, it installs a systemd script. On other versions it will install a 'zeronet' script which runs zeronet properly.

All you need is enter the following text into a terminal (note `sudo` is invoked):
```
pushd /tmp/;\
git clone https://github.com/bloff/zeronet-installs.git;\
pushd zeronet-installs/Ubuntu\ Linux/;\
sudo ./install_zeronet.sh;\
popd;\
rm -rf /tmp/zeronet-installs;\
popd
```

The installer downloads the latest zeronet version from git.
