#開發環境配置文件
"""
Django settings for rocket_mall project.

Generated by 'django-admin startproject' using Django 3.1.

For more information on this file, see
https://docs.djangoproject.com/en/3.1/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/3.1/ref/settings/
"""

from pathlib import Path
import sys
from django.shortcuts import redirect
from django.urls import reverse

# Build paths inside the project like this: BASE_DIR / 'subdir'.
BASE_DIR = Path(__file__).resolve(strict=True).parent.parent
sys.path.insert(0 ,str(BASE_DIR))
sys.path.insert(0 ,str(BASE_DIR.parent))
sys.path.insert(0 ,str(BASE_DIR / 'apps'))

# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/3.1/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = '7+imyuf^#q^+z)yu#vd$!zsg)e*-19znv-2y7yq2n9wt@52u0+'

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

ALLOWED_HOSTS = ['127.0.0.1','192.168.126.130','www.rocketmall.gq']

# Application definition

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'users',  # 用戶模塊
    'contents', #首頁模塊
    'verifications', # 驗證模塊
    'oauth', # 第三方登錄模塊
    'areas', # 收貨地址模塊
    'goods', # 商品模塊
    'haystack', # haystack
    'carts' , # 購物車模塊
    'orders' , # 訂單模塊
    'payment' , # 支付模塊
]

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

ROOT_URLCONF = 'rocket_mall.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.jinja2.Jinja2', #配置jinja2模板引擎提升SSR效能
        'DIRS': [BASE_DIR / "templates"], #配置模板文件加載路徑
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
            #配置jinja2模板引擎環境
            'environment':'rocket_mall.utils.jinja2_env.jinja2_environment',
        },
    },
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'rocket_mall.wsgi.application'


# Database
# https://docs.djangoproject.com/en/3.1/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql', # 數據庫引擎
        'HOST': '172.18.0.2', # 數據庫主機
        'PORT': 3306, # 數據庫端口
        'USER': 'rocket_it', # 數據庫用戶名
        'PASSWORD': '123456', # 數據庫密碼
        'NAME': 'rocket_mall',
    }
}

#配置redis數據庫
CACHES = {
    "default": { #default
        "BACKEND": "django_redis.cache.RedisCache",
        "LOCATION": "redis://:123@172.19.0.2:6379/0", # :password@
        "OPTIONS": {
            "CLIENT_CLASS": "django_redis.client.DefaultClient",
        }
    },
    "session": { #session
        "BACKEND": "django_redis.cache.RedisCache",
        "LOCATION": "redis://:123@172.19.0.2:6379/1", # :password@
        "OPTIONS": {
            "CLIENT_CLASS": "django_redis.client.DefaultClient",
        }
    },
    "verify_code": { #verify_code
        "BACKEND": "django_redis.cache.RedisCache",
        "LOCATION": "redis://:123@172.19.0.2:6379/2", # :password@
        "OPTIONS": {
            "CLIENT_CLASS": "django_redis.client.DefaultClient",
        }
    },
    "history": { #history
        "BACKEND": "django_redis.cache.RedisCache",
        "LOCATION": "redis://:123@172.19.0.2:6379/3", # :password@
        "OPTIONS": {
            "CLIENT_CLASS": "django_redis.client.DefaultClient",
        }
    },
    "cart": { #cart
        "BACKEND": "django_redis.cache.RedisCache",
        "LOCATION": "redis://:123@172.19.0.2:6379/4", # :password@
        "OPTIONS": {
            "CLIENT_CLASS": "django_redis.client.DefaultClient",
        }
    },
}
SESSION_ENGINE = "django.contrib.sessions.backends.cache"
SESSION_CACHE_ALIAS = "session"

# Password validation
# https://docs.djangoproject.com/en/3.1/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]


# Internationalization
# https://docs.djangoproject.com/en/3.1/topics/i18n/

#LANGUAGE_CODE = 'en-us'
LANGUAGE_CODE = 'zh-Hant'

#TIME_ZONE = 'UTC'
TIME_ZONE = 'Asia/Taipei'

USE_I18N = True

USE_L10N = True

USE_TZ = True


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/3.1/howto/static-files/

#指定加載靜態文件路由前綴
STATIC_URL = '/static/'
#配置靜態文件加載路徑
STATICFILES_DIRS = [ BASE_DIR / 'static' ]

#配置工程的日誌
LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'formatters': {
        'verbose': {
            'format': '%(levelname)s %(asctime)s %(module)s %(lineno)d %(message)s'
        },
        'simple': {
            'format': '%(levelname)s %(module)s %(lineno)d %(message)s'
        },
    },
    'filters': {
        'require_debug_true': {
            '()': 'django.utils.log.RequireDebugTrue',
        },
    },
    'handlers': {
        'console': {
            'level': 'INFO',
            'filters': ['require_debug_true'],
            'class': 'logging.StreamHandler',
            'formatter': 'simple'
        },
        'file': {
            'level': 'INFO',
            'class': 'logging.handlers.RotatingFileHandler',
            'filename': BASE_DIR.parent / 'logs/rocket.log',  # 日誌文件的位置
            'maxBytes': 300 * 1024 * 1024,
            'backupCount': 10,
            'formatter': 'verbose'
        },
    },
    'loggers': {
        'django': {
            'handlers': ['console', 'file'],
            'propagate': True,
            'level': 'INFO',
        },
    }
}

#指定自定義用戶模型類
AUTH_USER_MODEL = 'users.User'

#指定自定義用戶認證後端
AUTHENTICATION_BACKENDS = ['users.utils.LoginBackend']

#判斷用戶是否登入後，指定未登入用戶重定向的地址
LOGIN_URL = '/api/login_info/'

#Line專案app的ChannelID
Line_ChannelID = '1654901419'

#Line專案app的Channel_secret
Line_Channel_secret = '73639c8afde4343fbcdcf782f04be2a7'

#郵件參數
EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'
EMAIL_HOST = 'smtp.gmail.com'
EMAIL_POST = 587
EMAIL_HOST_USER = 'aidansky0989@gmail.com'
EMAIL_HOST_PASSWORD = 'aidan34781'
EMAIL_FROM = '羅奇商城<aidansky0989@gmail.com>'
EMAIL_USE_TLS = True
EMAIL_USE_SSL = False

#郵箱驗證鏈接
EMAIL_VERIFY_URL = 'http://192.168.126.130:8000/api/email/verification/get/'

#指定自定義文件存儲類
DEFAULT_FILE_STORAGE = 'rocket_mall.utils.fastdfs.fdfs_storage.FastdfsStorage'

#fastdfs容器
FASTDFS_BASE_URL = 'http://172.20.0.3:8888/'

#haystack
HAYSTACK_CONNECTIONS = {
    'default': {
        'ENGINE': 'haystack.backends.elasticsearch_backend.ElasticsearchSearchEngine',
        'URL': 'http://172.21.0.2:9200/', #Elasticsearch服務器ip地址，端口固定為9200
        'INDEX_NAME': 'rocket_mall', #Elasticsearch建立的索引庫的名稱
    },
}

#當添加、修改、刪除數據時，自動生成索引
HAYSTACK_SIGNAL_PROCESSOR = 'haystack.signals.RealtimeSignalProcessor'

#haystack分頁每頁條數
HAYSTACK_SEARCH_RESULTS_PER_PAGE = 5

#支付寶SDK參數
ALIPAY_APPID = '2021000120607159'
ALIPAY_DEBUG = True
ALIPAY_URL = 'https://openapi.alipaydev.com/gateway.do' #dev環境URL
ALIPAY_RETURN_URL = 'http://192.168.126.130:8000/api/payment/status/'
