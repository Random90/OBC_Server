
USER="dietpi"
USER_GROUP="dietpi"
REPO="https://github.com/Random90/OBC_Server.git"
SERVICE_FILE="/etc/systemd/system/obc_server.service"
INSTALL_LOCATION="/home/$USER/prod"
LOG_FILE="/var/log/obc_server.log"

if [ "$EUID" -ne 0 ]; then
     echo "Run this script as root user"
    exit
fi


if [ -n "$1" -a -n "$2" ]; then 
   USER=$1
   USER_GROUP=$2
else
    echo "User and group not provided. Using default user dietpi:dietpi"
fi

echo "Installing as a system wide service"
if test -f "$SERVICE_FILE"; then
    echo "Already installed, stopping service for update"
    systemctl stop obc_server
else
    cat > $SERVICE_FILE <<-EOF
        [Unit]
        Description=OBC_Server

        [Service]
        User=$USER
        Group=$USER_GROUP
        ExecStart=/home/$USER/prod/OBC_Server/prod_deploy_scripts/run.sh
        ExecStop=uwsgi --stop /tmp/obc_server.pid
        Restart=on-failure

        [Install]
        WantedBy=multi-user.target
EOF
    systemctl enable obc_server
fi


if [ ! -f "$LOG_FILE" ]; then
    echo "Creating log folder and file"
    touch ${LOG_FILE} || exit 1;
    chown ${USER}:${USER_GROUP} ${LOG_FILE}
    chmod 664 ${LOG_FILE}
fi

if [ ! -d "$INSTALL_LOCATION" ]; then
    echo "Downloading project"
    mkdir "$INSTALL_LOCATION"
    chown -R chown -R ${USER}:${USER_GROUP} ${INSTALL_LOCATION}
    cd "$INSTALL_LOCATION"
    git clone ${REPO}
    chown -R ${USER}:${USER_GROUP} OBC_Server
    cd OBC_Server
else
    echo "OBC_Server already installed, updating"
    cd "$INSTALL_LOCATION"/OBC_Server
    git pull
    cd ..
    chown -R ${USER}:${USER_GROUP} OBC_Server
    cd OBC_Server
fi

if [ ! -d venv ]; then
    echo "Creating virtual enviroment"
    python3 -m venv venv || exit 1
fi
echo "Setting up virtual env"
source venv/bin/activate || exit 1

echo "Installing OBC_Server dependencies"
pip3 install -r requirements.txt

echo "Generating Django secret key..."
DJANGO_SECRET_KEY=`openssl rand -base64 48`
if [ $? -ne 0 ]; then
    echo "Error creating secret key."
    exit 1
fi
echo $DJANGO_SECRET_KEY > .django_secret_key
chown ${USER}:${USER_GROUP} .django_secret_key

echo "Starting OBC_Server! Make your bikes wheels spinning!"
systemctl start obc_server.service

# @TODO setup web server and database

# # [uwsgi] obc_server
# server.modules += ( "mod_scgi" )
# scgi.protocol = "uwsgi"
# scgi.server = (
#   "/obc_server" => (( "host" => "127.0.0.1", "port" => 42137, "check-local" => "disable" )),
# )
