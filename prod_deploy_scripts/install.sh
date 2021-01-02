REPO="https://github.com/Random90/OBC_Server.git"

mkdir ~/prod
cd ~/prod/
git clone ${REPO}
if [ $? -ne 0 ]; then
    echo "OBC_Server repository already cloned, updating"
    cd "OBC_Server"
    git pull
else
    cd "OBC_Server"
fi

echo "Setting up virtual env"
python3 -m venv venv || exit 1
source venv/bin/activate

# @TODO remove some devOny deps
echo "Installing OBC_Server dependencies"
pip3 install -r requirements.txt

echo "Installing uWSGI"
pip3 install uwsgi

echo "Generating Django secret key..."
DJANGO_SECRET_KEY=`openssl rand -base64 48`
if [ $? -ne 0 ]; then
    echo "Error creating secret key."
    exit 1
fi
echo $DJANGO_SECRET_KEY > .django_secret_key
chown dietpi:dietpi .django_secret_key