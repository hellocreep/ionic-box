#!/usr/bin/env bash

ANDROID_SDK_FILENAME=android-sdk_r23.0.2-linux.tgz
ANDROID_SDK=http://dl.google.com/android/$ANDROID_SDK_FILENAME

#sudo apt-get install python-software-properties
#sudo add-apt-repository ppa:webupd8team/java
apt-get update
apt-get install -y nodejs nodejs-legacy npm git openjdk-7-jdk ant expect

curl -O $ANDROID_SDK
tar -xzvf $ANDROID_SDK_FILENAME
sudo chown -R vagrant android-sdk-linux/

echo "export ANDROID_HOME=~/android-sdk-linux" >> /home/vagrant/.bashrc
echo "export PATH=\$PATH:~/android-sdk-linux/tools:~/android-sdk-linux/platform-tools" >> /home/vagrant/.bashrc
echo "export export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-i386" >> /home/vagrant/.bashrc

npm install -g cordova
npm install -g ionic
expect -c '
set timeout -1   ;
spawn /home/vagrant/android-sdk-linux/tools/android update sdk -u --all --filter platform-tool,android-19,build-tools-19.1.0
expect {
    "Do you accept the license" { exp_send "y\r" ; exp_continue }
    eof
}
'

sudo /home/vagrant/android-sdk-linux/platform-tools/adb kill-server
sudo /home/vagrant/android-sdk-linux/platform-tools/adb start-server
sudo /home/vagrant/android-sdk-linux/platform-tools/adb devices
