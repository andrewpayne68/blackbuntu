### Troubleshooting

* * *

#### 1. Enable/Disable `apt_news` notification

To disable Pro config `apt_news`

```shell
sudo pro config set apt_news=false
```

To revert it to initial configuration

```shell
sudo pro config set apt_news=true
```

* * *

#### 2. Fixing `Key is stored in legacy trusted.gpg keyring`

If you use a PPA or add an external repository in BlackBuntu v22.04 and later versions, chances are that you will see sooner or later a message like this:

```plain
W: [...] Key is stored in legacy trusted.gpg keyring (/etc/apt/trusted.gpg), see the DEPRECATION section in apt-key(8) for details.
```

To resolve this issue simply run the following command in your Terminal.

```shell
sudo cp /etc/apt/trusted.gpg /etc/apt/trusted.gpg.d
```

* * *

#### 3. Lost `Softwares and Updates` after system upgrade

If you lost the Softwares and Updates icon launcher after you just upgraded the system simply execute the following command from your terminal.

```shell
sudo apt-get -y install apturl gnome-remote-desktop nautilus-share python3-software-properties software-properties-common software-properties-gtk ubuntu-advantage-tools update-notifier update-notifier-common
```

* * *

#### 4. Receive 404 error when trying to install Tor Browser

If you get an error 404 while you're trying to install or update TOR Browser this is what you need to do.

```shell
rm -rf /home/$USER/.cache/torbrowser && rm -rf /home/$USER/.local/share/torbrowser
```

Edit the file located in /usr/lib/python3/dist-packages/torbrowser_launcher/common.py line 171 and save it.

```shell
language = "ALL"
```

Edit the file located in /usr/lib/python3/dist-packages/torbrowser_launcher/common.py line 223 and save it.

```shell
"tbb": {
    "changelog": tbb_local,
    + "/tbb/",
    + self.architecture,
    + "/tor-browser",
    + "/Browser/TorBrowser/Docs/ChangeLog.txt",
    "dir": tbb_local + "/tbb/" + self.architecture,
    "dir_tbb": tbb_local,
    + "/tbb/",
    + self.architecture,
    + "/tor-browser",
    "start": tbb_local,
    + "/tbb/",
    + self.architecture,
    + "/tor-browser",
    + "/start-tor-browser.desktop",
},
```
