# -*- coding: utf-8 -*-
import os
import platform
import time

from fabric.api import cd, env, local, run, settings
from fabric.contrib import project
from fabric.operations import get

HERE = os.path.abspath(os.path.dirname(__file__))
env.hosts = ['root@mi-tang.com']
env.port  = '9922'

env.excludes = (
    "*.pyc", "*.db", ".DS_Store", ".coverage", ".git", ".hg", ".tox", ".idea/",
    'assets/', 'runtime/', 'node_modules', 'db.sqlite3', '*.ipynb')

env.remote_dir = '/home/www/mi-tang.com/vod'
env.local_dir = os.getcwd() + os.sep
env.database = 'mt_vod'

def sync():
    return project.rsync_project(remote_dir=env.remote_dir, local_dir=env.local_dir, exclude=env.excludes, delete=True)


def setup():
    local('chmod -R 777 runtime')
    local('chmod -R 777 assets/media')
    #local('ln -s assets/media media')
    #local('ln -s assets/static static')


def d2u():
    if platform.system() == 'Windows':
        local('xfind . -name "*.html" | xargs dos2unix')
#        local('xfind . -name "*.php" | xargs dos2unix')
        local('xfind . -name "*.css" | xargs dos2unix')
        local('xfind . -name "*.js" | xargs dos2unix')
    else:
        local('find . -name "*.html" | xargs dos2unix')
        local('find . -name "*.php" | xargs dos2unix')
        local('find . -name "*.css" | xargs dos2unix')
        local('find . -name "*.js" | xargs dos2unix')


def prod():
    local('''sed -i 's/TRUE/FALSE/g' index.php''')


def clean(host='local'):
    if host == 'remote':
        run('rm -rf runtime/Cache/*')
        run('rm -rf runtime/Logs/*')
        run('rm -rf runtime/Temp/*')
        run('find . -name Thumbs.db |xargs rm -rf')
        run('find . -name *.bak |xargs rm -rf')
    else:
        if platform.system() == 'Windows':
            local('del runtime\\Cache\\*.* /s/q')
            local('del runtime\\Logs\\*.* /s/q')
            local('del runtime\\Temp\\*.* /s/q')
            local('del Thumbs.db /s/q')
            local('del *.bak /s/q')
            local('del *.log /s/q')
            local('del *.tgz')
            local('del *.sql')
        else:
            local('rm -rf runtime/*/*')
            local('rm -rf *.tgz; rm -rf *.sql')
            local('find . -name Thumbs.db |xargs rm -rf')
            local('find . -name *.bak |xargs rm -rf')
            local('find . -name *.log |xargs rm -rf')


# def distclean(host='local'):
#     clean(host)

#     if host == 'remote':
#         run('rm -rf assets/media/uploads/*')
#     else:
#         if platform.system() == 'Windows':
#             local('del assets\\media\\uploads\\*.* /s/q')
#         else:
#             local('rm -rf assets/media/uploads/*')


def syn(path = ''):
    with cd(HERE):
        currdir = os.path.join('protected', path)
        for x in os.walk(currdir):
            for f in x[2]:
                if(f is not None):
                    file = os.path.join(x[0], f)
                    if(os.path.splitext(f)[1] == '.php'):
                        local('php -l %s' % file)


def pack():
    clean()
    local('tar zcfv biao.tgz --exclude=.git --exclude=.svn --exclude=.phpintel --exclude=.idea .')
