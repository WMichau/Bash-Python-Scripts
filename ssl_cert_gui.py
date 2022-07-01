#!/usr/bin/env python3

# import modules
import os, os.path, sys, shutil, pathlib, subprocess
try:
    from PyQt5.QtCore import *
    from PyQt5.QtGui import *
    from PyQt5.QtWidgets import *
except:
    os.system("pip install PyQt5")
    from PyQt5.QtCore import *
    from PyQt5.QtGui import *
    from PyQt5.QtWidgets import *

def main():
    app = QApplication(sys.argv)
    Window = QWidget()

    main.ChefLabel = QLabel(Window)
    main.ChefLabel.resize(200,20)

    #////////////////////////////////////
    KnifeBlockList = subprocess.Popen(('knife', 'block', 'list'), stdout=subprocess.PIPE)
    grepCurrentlySelected = subprocess.check_output(('grep', '-e', 'Currently'), stdin=KnifeBlockList.stdout).strip()

    if 'waw' in str(grepCurrentlySelected):
        main.ChefLabel.setText("Warszawa")
    else:
        main.ChefLabel.setText("Gdańsk")
    #////////////////////////////////////


    button1 = QPushButton(Window)
    button1.setText("Git Pull")
    button1.move(64,32)
    button1.clicked.connect(GitPullAction)

    button2 = QPushButton(Window)
    button2.setText("Change Chef Server")
    button2.move(64,64)
    button2.clicked.connect(ChangeChefServer)

    Window.setGeometry(50,50,320,200)
    Window.setWindowTitle("SSL_Cert")
    
    Window.show()
    sys.exit(app.exec_())


def GitPullAction():
    os.system("cd ~/chef/chef-repo && git pull --rebase")

def ChangeChefServer():    
    
    KnifeBlockList = subprocess.Popen(('knife', 'block', 'list'), stdout=subprocess.PIPE)
    grepCurrentlySelected = subprocess.check_output(('grep', '-e', 'Currently'), stdin=KnifeBlockList.stdout).strip()
    
    os.system("cd ~/chef/chef-repo")
    if 'waw' in str(grepCurrentlySelected):
        os.system("knife block gda")
        main.ChefLabel.setText("Gdańsk")
    else:
        os.system("knife block waw")
        main.ChefLabel.setText("Warszawa")

if __name__ == '__main__':
    main()
