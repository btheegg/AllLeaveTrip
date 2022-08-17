import os
from .base import *

# def read_secret(secret_name):
#     file = open('/run/secrets/' + secret_name)
#     secret = file.read()
#     secret = secret.rstrip().lstrip()
#     file.close()
#     return secret


# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/4.0/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = 'django-insecure-yp1&^4cag9sc)34y0i+os*!+%0bi=n+%acu4v2+t)7^cl!_may'

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = False

ALLOWED_HOSTS = ['*']


# Database
# https://docs.djangoproject.com/en/4.0/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': "altdb",
        'USER': "altdb",
        'PASSWORD': 1234,
        'HOST': 'mysql',
        'PORT': '3306',
    }
}