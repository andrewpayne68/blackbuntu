### Extras

* * *

#### 1. Install `libreoffice`

```shell
sudo apt-get -y install libreoffice
```

* * *

#### 2. Install `evolution`

```shell
sudo apt-get -y install evolution evolution-ews
```

* * *

#### 3. Install `burpsuite`

* * *

```shell
wget -O "/tmp/jdk-17_linux-x64_bin.deb" "https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.deb"
wget -O "/tmp/jdk-19_linux-x64_bin.deb" "https://download.oracle.com/java/19/latest/jdk-19_linux-x64_bin.deb"
sudo dpkg -i /tmp/jdk-17_linux-x64_bin.deb
sudo dpkg -i /tmp/jdk-19_linux-x64_bin.deb
sudo apt-get -y install openjdk-17-jdk openjdk-17-jre openjdk-19-jdk openjdk-19-jre
wget -O "/tmp/burpsuite.sh" "https://portswigger-cdn.net/burp/releases/download?product=community&type=Linux"
sudo chmod +x /tmp/burpsuite.sh
sudo /tmp/burpsuite.sh
```

* * *

#### 4. Install `maltego`

```shell
wget -O "/tmp/Maltego.v4.3.1.deb" "https://maltego-downloads.s3.us-east-2.amazonaws.com/linux/Maltego.v4.3.1.deb"
sudo dpkg -i /tmp/Maltego.v4.3.1.deb
```

* * *

#### 5. Install `metasploit`

```shell
wget -O "/tmp/msfinstall" "https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb"
chmod +x /tmp/msfinstall
/tmp/msfinstall
sudo cp /etc/apt/trusted.gpg /etc/apt/trusted.gpg.d
sudo apt-get -y update
```

* * *

#### 6. Install `electrum-btc`

```shell
sudo apt-get -y install electrum-btc
```

* * *

#### 7. Install `electrum-ltc`

```shell
sudo apt-get -y install electrum-ltc
```

* * *

#### 8. Install `cubic`

```shell
sudo apt-add-repository -y ppa:cubic-wizard/release
sudo apt-get -y update && sudo apt-get -y install cubic
```

* * *

#### 9. Install `sublime-text`

```shell
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg >/dev/null
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list >/dev/null
sudo apt-get -y update && sudo apt-get -y install sublime-text
```

#### 10. Install `filezilla`

```shell
sudo apt-get -y install filezilla
```

* * *

#### 11. Install `shutter`

```shell
sudo apt-get -y install shutter
```

* * *

#### 12. Install `git-lfs`

```shell
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
sudo apt-get install git-lfs
```

* * *

#### 13. Install `gimp`

```shell
sudo apt-get -y install gimp gimp-data gimp-data-extras gimp-plugin-registry gimp-texturize
```

* * *

#### 14. Install `inkscape`

```shell
sudo apt-get -y install inkscape
```

* * *

#### 15. Install `kdenlive`

```shell
sudo apt-get -y install kdenlive
```

* * *

#### 16. Install `SqliteBrowser`

```shell
sudo apt-get -y install sqlitebrowser
```