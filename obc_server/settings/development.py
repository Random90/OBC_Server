from obc_server.settings.common import *

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = 'zl(lpa+=(o&l#y@rpq2ovw_ex@1%%i9poz)m(y(mkl7p=bwqpm'

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

SESSION_COOKIE_SECURE = False
CSRF_COOKIE_SECURE = False


REST_FRAMEWORK = {
    'DEFAULT_AUTHENTICATION_CLASSES': [
        'rest_framework.authentication.BasicAuthentication',
        'rest_framework.authentication.SessionAuthentication',
        'rest_framework.authentication.TokenAuthentication'
    ],
    'DEFAULT_PERMISSION_CLASSES': (
        'rest_framework.permissions.IsAuthenticated',
    ),
}


ALLOWED_HOSTS = [
    '192.168.0.40',
    'malina9.ddns.net',
    '127.0.0.1',
    'localhost'
]
