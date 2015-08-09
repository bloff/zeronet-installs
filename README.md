# zeronet-installs
Software for installing zeronet.

Currently we have an installer for Ubuntu, and an [NSIS](nsis.sourceforge.net) script for making a Windows installer.

*TODO*: A MacOS, single-file `zeronet.dmg` installer.

## Ubuntu

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
*TODO*: Integrate with upstart in earlier versions of ubuntu.
*TODO*: Other distributions.

The installer downloads the latest zeronet version from git.


## Windows

An [NSIS](nsis.sourceforge.net) script is available. You can get the outcome of compilation in the [releases page](https://github.com/bloff/zeronet-installs/releases).

To compile you need to:
 1. Download [ZeroBundle](https://github.com/HelloZeroNet/ZeroBundle/releases/download/0.1.0/ZeroBundle-v0.1.0.zip).
 2. Extract the `Python` directory, and the `zeronet.cmd` file into `zeronet-installs/Windows`.

*TODO*: make the uninstaller backup important information (identities, etc), and allow the installer to restore from it.
*TODO*: Browser extension for Firefox.
*TODO*: Automatical installation of browser extensions.