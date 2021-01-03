# OBC_Server
OpenBikeComputer Server

Provides APIs for OpenBikeComputer devices for synchronizing riding data
Based on Python Django REST Framework

## Prerequisites

- Installed and configured webserver with uWSGI support (socket: 127.0.0.1:42137). I will add later automatic installation and configuration of lighttpd webserver.

- Installed and fully configured mariaDB database for OBC_Server (migration and instalation in the `install.sh` are TODO also)
## Installation

### Debian-based Linux (like Raspbian or DietPi for raspberryPi)

- Download `install.sh` and `install_os_prereq.sh` located in `prod_deploy_scripts`.

- Run as root `sudo ./install_os_prereq.sh` to install python and other core packages. You have to do it only once per system.

- To install or update OBC_Server, run as root `sudo ./install.sh user group`,  where user and group will be used for running application (they must already exists with /home/user folder). Python3 virtual enviroment will be used.

- Script will install/update the OBC_server in /home/user/prod/OBC_Server directory along with this installation scripts. You can use `install.sh` from installation folder to update the server files.

To stop the server manually run `systemctl stop obc_server`.
By default OBC_Server is ran at startup. To disable autostart do `systemctl disable obc_server`. To start manually: `systemctl start obc_server`.
