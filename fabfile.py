# -*- coding: utf-8 -*-
from fabric.operations import get
from fabric.api import settings, local, run, env, cd
import platform, time, os
#from faker import Factory
#import requests,json

HERE = os.path.abspath(os.path.dirname(__file__))
env.hosts = ['root@t119.baduhost.cn']
#env.port  = '9922'


#DBNAME = 'biao'
#DBUSER = 'root'
#DBPASS = 'a.123456'

def push():
    local('''svn ci -m '%s' protected/Lib/''' % time.strftime('%Y-%m-%d %H:%M', time.localtime(time.time())))
    local('''svn ci -m '%s' protected/Views/''' % time.strftime('%Y-%m-%d %H:%M', time.localtime(time.time())))

    run('svn up /home/www/biaopingtai.com/wx/protected/Lib/')
    run('svn up /home/www/biaopingtai.com/wx/protected/Views/')

        
def ci():
    local('svn up')
    local('svn ci -m "%s"' % time.strftime('%Y-%m-%d %H:%M', time.localtime(time.time())))


def up():
    run('cd ~/biao; svn up; fab clean')


def pub():
    local('chmod -R 777 runtime')
    local('chmod -R 777 assets/media')
    #local('ln -s assets/media media')
    #local('ln -s assets/static static')


# def d2u():
#     if platform.system() == 'Windows':
#         local('xfind . -name "*.html" | xargs dos2unix')
# #        local('xfind . -name "*.php" | xargs dos2unix')
#         local('xfind . -name "*.css" | xargs dos2unix')
#         local('xfind . -name "*.js" | xargs dos2unix')
#     else:
#         local('find . -name "*.html" | xargs dos2unix')
#         local('find . -name "*.php" | xargs dos2unix')
#         local('find . -name "*.css" | xargs dos2unix')
#         local('find . -name "*.js" | xargs dos2unix')

def prod():
    local('''sed -i 's/TRUE/FALSE/g' index.php''')


def dev():
    local('''sed -i 's/FALSE/TRUE/g' index.php''')


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


# def allow():
#     import re
#     with cd(HERE):
#         currdir = os.path.join('protected', 'Lib','Action')
#         for x in os.walk(currdir):
#             for f in x[2]:
#                 if(f is not None):
#                     file = os.path.join(x[0], f)
#                     if(os.path.splitext(f)[1] == '.php'):
#                         print file
#                         allows = re.findall(r'_isAllow\(\'(\w+)\'\)', open(file,'r').read())
#                         # print allows, len(allows)
#                         if(len(allows) > 0):
#                             print allows[0]
#                             open('allow.txt','a').write(allows[0]+'\n')
#                             # for x in allows:
#                                 # print x


def pack():
    clean()
    local('tar zcfv biao.tgz --exclude=.git --exclude=.svn --exclude=.phpintel --exclude=.idea .')


def backup():
    clean()
    package = time.strftime('%Y-%m-%d', time.localtime(time.time()))
    if platform.system() == 'Windows':
        local('tar -cvf ../backup/%s/%s.tar --exclude=.git --exclude=.svn .' % (APPNAME, package))
        local('gzip -f ../backup/%s/%s.tar' % (APPNAME, package))
    else:
        local('tar zcfv backup-%s.tgz --exclude=.git --exclude=.svn .' % package)
