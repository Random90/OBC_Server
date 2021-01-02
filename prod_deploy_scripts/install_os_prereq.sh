if [ "$EUID" -ne 0 ]; then
     echo "Run this script as root user"
    exit
fi
# @TODO setup web server and database

LINUX_PREREQ="git build-essential python3-dev python3-pip"
PYTHON_PREREQ="virtualenv"

# Test prerequisites
echo "Checking if required packages are installed..."
apt-get -y install $pkg
if [ $? -ne 0 ]; then
    echo "Error installing system packages"
    exit 1
fi

for ppkg in "${PYTHON_PREREQ[@]}"
    do
        echo "Installing Python package '$ppkg'..."
        pip3 install $ppkg
        if [ $? -ne 0 ]; then
            echo "Error installing python package '$ppkg'"
            exit 1
        fi
    done

echo "All required packages have been installed!"

echo "Creating log folder and file"

touch /var/log/obc_server.log
chown dietpi:dietpi /var/log/obc_server.log
chmod 664 /var/log/obc_server.log
