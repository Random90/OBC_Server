if [ "$EUID" -ne 0 ]; then
     echo "Run this script as root user"
    exit
fi

LINUX_PREREQ="git build-essential python3-dev python3-pip"
PYTHON_PREREQ=('virtualenv' 'uwsgi')

# Test prerequisites
echo "Checking if required packages are installed..."
apt-get -y install $pkg
if [ $? -ne 0 ]; then
    echo "Error installing system packages"
    exit 1
fi

/usr/bin/python3 -m pip install --upgrade pip

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
