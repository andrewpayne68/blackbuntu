#!/bin/bash

## ---------------- ##
## Define Variables ##
## ---------------- ##

## Colour output
## -------------
t_error="\033[01;31m"	# Error
t_valid="\033[01;32m"	# Valid
t_alert="\033[01;33m"	# Alert
t_title="\033[01;34m"	# Title
t_reset="\033[00m"		# Reset

## Clear screen
## ------------
function clearscreen()
{
	clear
	sleep 2s
}

## Keep alive
## ----------
function keepalive()
{
	sudo -v
	while true;
	do
		sudo -n true;
		sleep 60s;
		kill -0 "$$" || exit;
	done 2>/dev/null &
}

## Load banner
## -----------
function showbanner()
{
	clear
	echo -e "${t_error}  _     _            _    _                 _          ${t_reset}"
	echo -e "${t_error} | |   | |          | |  | |               | |         ${t_reset}"
	echo -e "${t_error} | |__ | | __ _  ___| | _| |__  _   _ _ __ | |_ _   _  ${t_reset}"
	echo -e "${t_error} | '_ \| |/ _' |/ __| |/ / '_ \| | | | '_ \| __| | | | ${t_reset}"
	echo -e "${t_error} | |_) | | (_| | (__|   <| |_) | |_| | | | | |_| |_| | ${t_reset}"
	echo -e "${t_error} |_'__/|_|\__'_|\___|_|\_\_'__/ \__'_|_| |_|\__|\__'_| ${t_reset}"
	echo -e "${t_error}                                      v22.04 LTS amd64 ${t_reset}"
	echo
	echo -e "${t_valid}[i] [Package]: blackbuntu-builder${t_reset}"
	echo -e "${t_valid}[i] [Website]: https://blackbuntu.org${t_reset}"
  	sleep 3s
}

## Check Internet status
## ---------------------
function checkinternet()
{
	for i in {1..10};
	do
		ping -c 1 -W ${i} www.google.com &>/dev/null && break;
	done

	if [[ "$?" -ne 0 ]];
	then
		echo
		echo -e "${t_error}Error ~ Possible DNS issues or no Internet connection${t_reset}"
		echo -e "${t_error}Quitting ...${t_reset}\n"
		exit 1
	fi
}

## Warning
## -------
function warning()
{
	echo
    echo -e "${t_error}*** Warning ***${t_reset}"
    echo -e "${t_error}You are about to build BlackBuntu Linux from scratch${t_reset}"
    echo -e "${t_error}We recommend to exit all other programs before to proceed${t_reset}"
    echo
    read -p "Do you want to continue? [y/N] " yn
    case $yn in
        [Yy]* )
			echo
            ;;
        [Nn]* )
            exit
            ;;
        * )
            exit
            ;;
    esac
}

## Export environment
## ------------------
function exportenv()
{
	export PYTHONWARNINGS=ignore
}

## Configure APT sources
## ---------------------
function aptsources()
{
	add-apt-repository -y main
	add-apt-repository -y restricted
	add-apt-repository -y universe
	add-apt-repository -y multiverse

	cd /tmp/
	wget --quiet -O - https://packages.blackbuntu.org/pubkey.asc | tee /etc/apt/keyrings/blackbuntu-pubkey.asc >/dev/null 2>&1
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/blackbuntu-pubkey.asc] https://packages.blackbuntu.org $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/blackbuntu.list >/dev/null 2>&1
	apt-get -y update
	cd /root/
}

## Clean orphaned packages
## -----------------------
function cleanorphans()
{
	apt-get -y purge --auto-remove zsys >/dev/null 2>&1
}

## Keep system safe
## ----------------
function systemupdate()
{
	apt-get -y update && apt -y upgrade && apt -y dist-upgrade
	apt-get -y remove && apt -y autoremove
	apt-get -y clean && apt -y autoclean
}

## Disable error reporting
## -----------------------
function disableapport()
{
	sed -i "s/enabled=1/enabled=0/" /etc/default/apport
}

## Remove unwanted packages
## ------------------------
function removeunwanted()
{
	apt-get -y purge --auto-remove aisleriot gnome-initial-setup gnome-mahjongg gnome-mines gnome-sudoku thunderbird transmission libreoffice*
}

## Clone Github repository
## -----------------------
function clonegithub()
{
	cd /tmp/
	git clone https://github.com/neoslab/blackbuntu
	cd /root/
}

## Install `kernel`
## ----------------
function installkernel()
{
	apt-get -y install linux-generic
}

## Install `dejavu` font
## ---------------------
function installfonts()
{
	apt-get -y install fonts-dejavu
}

## Install `gnome` extras
## ----------------------
function installgnome()
{
	apt-get -y install gnome-shell-extension-manager gnome-shell-extensions gnome-firmware gnome-tweaks
}

## Install system libraries
## ------------------------
function installlibs()
{
	apt-get -y install libbz2-dev libc6-x32 libcurl4-openssl-dev libffi-dev libfmt-dev libfuse2 libgdbm-dev libglib2.0-dev libglib2.0-dev-bin libgmp-dev libgspell-1-dev libgtkmm-3.0-dev libgtksourceviewmm-3.0-dev libncurses5-dev libnss3-dev libreadline-dev libsodium-dev libspdlog-dev libsqlite3-dev libssl-dev libtool libuchardet-dev libxml2 libxml++2.6-dev libxml2-dev libxslt1-dev zlib1g-dev
}

## Install `python`
## ----------------
function installpython()
{
	apt-get -y install python3-flask python3-future python3-geoip python3-httplib2 python3-numpy python3-paramiko python3-pip python3-psutil python3-pycurl python3-pyqt5 python3-requests python3-scapy python3-scipy python3-setuptools python3-urllib3 python3-virtualenv python3-wheel
	ln -s /usr/bin/python3 /usr/bin/python
}

## Install `Qt5`
## -------------
function installqt5()
{
	apt-get -y install pyqt5-dev pyqt5-dev-tools qttools5-dev-tools qt5-doc qt5-doc-html qtbase5-examples qtcreator
}

## Install `ruby`
## -------------
function installruby()
{
	apt-get -y install ruby ruby-dev
}

## Install `perl`
## -------------
function installperl()
{
	apt-get -y install perl-tk
}

## Install common packages
## -----------------------
function installcommons()
{
	apt-get -y install abootimg android-sdk apache2 apt-transport-https apt-utils atftp autoconf autopsy binutils binwalk build-essential cabextract cherrytree chirp cmake curl cutycapt debootstrap default-jdk default-jre dirmngr dkms dos2unix dpkg-sig easytag fuse3 fwbuilder g++ gcc gconf2 ghex git gnuradio gpg gqrx-sdr gr-air-modes gr-iqbal gr-osmosdr gss-ntlmssp hackrf hexedit httrack inspectrum jq kate keepassxc macchanger make mtools net-tools ninja-build openvpn pkg-config proxychains qemu rake reprepro screen screenfetch secure-delete simplescreenrecorder sqlitebrowser socat software-properties-common squashfs-tools synaptic tor torbrowser-launcher tree wget xorriso
}

## Install files roller
## --------------------
function installroller()
{
	apt-get -y install p7zip-full p7zip-rar rar unrar
}

## Install `wpscan`
## https://wpscan.com
## ------------------
function installwpscan()
{
	gem install wpscan
}

## Install cracking tools
## ----------------------
function installcracking()
{
	apt-get -y install bruteforce-luks bruteforce-salted-openssl bruteforce-wallet brutespray ccrypt cewl changeme cmospwd crack crunch fcrackzip gtkhash hashcat hashdeep hashid hashrat hydra john medusa nasty ncrack ophcrack patator princeprocessor sucrack
	apt-get -y install crowbar gpp-decrypt rainbowcrack rsmangler
}

## Install exploitation tools
## --------------------------
function installexploitation()
{
	apt-get -y install websploit yersinia weevely
	apt-get -y install cge commix exe2hex jexboss libenom routersploit sharpmeter shellnoob
}

## Install forensics tools
## -----------------------
function installforensics()
{
	apt-get -y install aesfix aeskeyfind afflib-tools chntpw dc3dd dcfldd de4dot dislocker ext3grep ext4magic extundelete fatcat flashrom foremost galleta guymager mac-robber magicrescue myrescue openocd o-saft outguess p0f parted pasco pdfcrack xmount
	apt-get -y install ddrescue dumpzilla pdfid pdf-parser
}

## Install hardening tools
## -----------------------
function installhardening()
{
	apt-get -y install apktool arduino lynis
	apt-get -y install dex2jar
}

## Install information gathering tools
## -----------------------------------
function installrecon()
{
	apt-get -y install arp-scan braa dmitry dnsenum dnsmap dnsrecon dnstracer dnswalk exifprobe exiv2 ike-scan masscan metacam missidentify nikto nmap nmapsi4 parsero recon-ng smbmap sntop sslsplit traceroute whois
	apt-get -y install enum4linux fierce gnmap lbd linenum phoneinfoga smtp-user-enum
}

## Install networking tools
## ------------------------
function installnetworking()
{
	apt-get -y install arpwatch axel cntlm cryptcat darkstat dns2tcp dnstwist dsniff ethtool firewalk ifenslave inetsim miredo nbtscan netcat netdiscover netmask netsed onesixtyone pnscan proxytunnel
	apt-get -y install cymothoa nishang powersploit pwnat reverser
}

## Install reverse engineering tools
## ---------------------------------
function installreverse()
{
	apt-get -y install edb-debugger valgrind yara
	apt-get -y install jad javasnoop
}

## Install sniffing & spoofing tools
## ---------------------------------
function installsnoofing()
{
	apt-get -y install bettercap chaosreader ettercap-common ettercap-graphical netsniff-ng wireshark
	apt-get -y install mitmdump mitmproxy mitmweb sniffjoke webscarab zaproxy
}

## Install stress testing tools
## ----------------------------
function installstressing()
{
	apt-get -y install arping dhcpig fping goldeneye hping3 slowhttptest t50 termineter
	apt-get -y install iaxflood rtpflood thc-ssl-dos udpflood
}

## Install utilities tools
## -----------------------
function installutils()
{
	apt-get -y install polenum
	apt-get -y install dracnmap ridenum subbrute webtrace
}

## Install vulnerability analysis tools
## ------------------------------------
function installvulns()
{
	apt-get -y install afl++ dirsearch doona pocsuite3 pompem sqlmap wapiti
	apt-get -y install bed jsql-injection sfuzz sidguesser tnscmd10g unix-privesc
}

## Install web applications tools
## ------------------------------
function installwebapps()
{
	apt-get -y install dirb ffuf gobuster wfuzz wafw00f whatweb wig
	apt-get -y install cmsmap dirbuster hurl
}

## Install wireless tools
## ----------------------
function installwireless()
{
	apt-get -y install aircrack-ng bully cowpatty iw mdk3 mdk4 mfcuk mfoc multimon-ng pixiewps reaver wifite
	apt-get -y install blueranger fluxion wifi-honey wps-breaker
}

## Configure system
## ----------------
function systemconfig()
{
	## Setup user `bashrc`
	## -------------------
	rm -f /etc/skel/.bashrc
	cp /tmp/blackbuntu/system/etc/skel/bashrc /etc/skel/.bashrc

	## Setup root `bashrc`
	## -------------------
	rm -f /root/.bashrc
	cp /tmp/blackbuntu/system/root/bashrc /root/.bashrc

	## Configure backgrounds
	## ---------------------
	rm -rf /usr/share/backgrounds/*
	cp /tmp/blackbuntu/system/usr/share/backgrounds/* /usr/share/backgrounds/
	rm -f /usr/share/gnome-background-properties/jammy-wallpapers.xml
	rm -f /usr/share/gnome-background-properties/ubuntu-wallpapers.xml
	cp /tmp/blackbuntu/system/usr/share/gnome-background-properties/* /usr/share/gnome-background-properties/

	## Configure utilities
	## -------------------
	cp /tmp/blackbuntu/system/usr/local/bin/blackbuntu /usr/local/bin/
	chmod +x /usr/local/bin/blackbuntu
	cp -r /tmp/blackbuntu/system/usr/share/blackbuntu /usr/share/
	chmod +x /usr/share/blackbuntu/usr/bin/cleaner
	chmod +x /usr/share/blackbuntu/usr/bin/system
	chmod +x /usr/share/blackbuntu/usr/bin/updater

	## Update `ubiquity`
	## -----------------
	rm -f /usr/share/ubiquity/pixmaps/cd_in_tray.png
	rm -f /usr/share/ubiquity/pixmaps/ubuntu_installed.png
	cp /tmp/blackbuntu/system/usr/share/ubiquity/pixmaps/cd_in_tray.png /usr/share/ubiquity/pixmaps/
	cp /tmp/blackbuntu/system/usr/share/ubiquity/pixmaps/ubuntu_installed.png /usr/share/ubiquity/pixmaps/

	## Replace `ubiquity-slideshow`
	## ----------------------------
	rm -rf /usr/share/ubiquity-slideshow
	cp -r /tmp/blackbuntu/system/usr/share/ubiquity-slideshow /usr/share/

	## Configure `pixmaps`
	## -------------------
	rm -f /usr/share/pixmaps/ubuntu-logo-dark.png
	cp /tmp/blackbuntu/system/usr/share/pixmaps/ubuntu-logo-dark.png /usr/share/pixmaps/
	rm -f /usr/share/pixmaps/ubuntu-logo-icon.png
	cp /tmp/blackbuntu/system/usr/share/pixmaps/ubuntu-logo-icon.png /usr/share/pixmaps/

	## Configure `plymouth`
	## --------------------
	rm -f /usr/share/plymouth/ubuntu-logo.png
	cp /tmp/blackbuntu/system/usr/share/plymouth/ubuntu-logo.png /usr/share/plymouth/
	rm -f /usr/share/plymouth/themes/spinner/watermark.png
	cp /tmp/blackbuntu/system/usr/share/plymouth/themes/spinner/watermark.png /usr/share/plymouth/themes/spinner/

	## Update `initframs`
	## ------------------
	update-initramfs -u

	## Import icons
	## ------------
	cp -r /tmp/blackbuntu/system/usr/share/icons/* /usr/share/icons/

	## Import applications desktop
	## ---------------------------
	cp /tmp/blackbuntu/system/usr/share/applications/* /usr/share/applications/

	## Edit system conf
	## ----------------
	sed -i "s/#DefaultTimeoutStartSec=90s/DefaultTimeoutStartSec=5s/" /etc/systemd/system.conf
	sed -i "s/#DefaultTimeoutStopSec=90s/DefaultTimeoutStopSec=5s/" /etc/systemd/system.conf

	## Correct Tor
	## -----------
	rm -f /usr/lib/python3/dist-packages/torbrowser_launcher/common.py
	cp /tmp/blackbuntu/system/usr/lib/python3/dist-packages/torbrowser_launcher/common.py /usr/lib/python3/dist-packages/torbrowser_launcher/

	## Change screenfetch
	## ------------------
	rm -f /usr/bin/screenfetch
	cp /tmp/blackbuntu/system/usr/bin/screenfetch /usr/bin/
	chmod +x /usr/bin/screenfetch

	## Edit LSB Release
	## ----------------
	rm -f /etc/lsb-release
	cp /tmp/blackbuntu/system/etc/lsb-release /etc/

	## Copy Dconf settings
	## -------------------
	mkdir -p /etc/dconf/db/local.d/locks
	cp /tmp/blackbuntu/system/etc/dconf/db/local.d/00-desktop-settings /etc/dconf/db/local.d/
	cp /tmp/blackbuntu/system/etc/dconf/profile/user /etc/dconf/profile/
	dconf update

	## Remove launchers
	## ----------------
	rm -rf /usr/share/applications/kde4
	rm -f /usr/share/applications/arduino.desktop
	rm -f /usr/share/applications/edb.desktop
	rm -f /usr/share/applications/ettercap.desktop
	rm -f /usr/share/applications/gtkhash.desktop
	rm -f /usr/share/applications/guymager.desktop
	rm -f /usr/share/applications/lstopo.desktop
	rm -f /usr/share/applications/lynis.desktop
	rm -f /usr/share/applications/ophcrack.desktop
	rm -f /usr/share/applications/org.wireshark.Wireshark.desktop
	rm -f /usr/share/applications/texdoctk.desktop
	rm -f /usr/share/applications/torbrowser-settings.desktop
	rm -f /usr/share/applications/ubiquity.desktop
}

## Clean system
## ------------
function systemclean()
{
	## Clean `tmp` directory
	## ---------------------
	rm -rf /tmp/*

	## Clean `bash` history
	## --------------------
	rm -f ~/.bash_history
	rm -f /root/.bash_history
}

## Launch
## ------
function launch()
{
	clearscreen
	keepalive
	showbanner
	checkinternet
	warning
	exportenv
	aptsources
	cleanorphans
	systemupdate
	disableapport
	removeunwanted
	installkernel
	installfonts
	installgnome
	installlibs
	installpython
	installqt5
	installruby
	installperl
	installcommons
	installroller
	systemupdate
	clonegithub
	installcracking
	installexploitation
	installforensics
	installhardening
	installrecon
	installnetworking
	installreverse
	installsnoofing
	installstressing
	installutils
	installvulns
	installwebapps
	installwireless
	installwpscan
	systemupdate
	systemconfig
	systemclean
}

## -------- ##
## Callback ##
## -------- ##

launch
