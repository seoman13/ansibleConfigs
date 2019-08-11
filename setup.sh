#!/bin/zsh

function uninstall {
	echo "You are going to uninstall brew and all packages installed through it"
	echo -n "Are you sure?[y/n]"
	read confirmation

	if [$confirmation == "y"]; then
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
		exit 0
	else
		echo "Doing nothing"
		exit 0
	fi
}

if [ $1 == "uninstall" ]; then
    uninstall
fi

echo "==========================================="
echo "Setting up Mac
echo "==========================================="

echo "Installing Homebrew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Installing pip"
sudo easy_install pip

echo "Installing Ansible"
sudo pip install ansible

installdir="/tmp/setupmac-$RANDOM"
mkdir $installdir

git clone https://github.com/seoman13/ansibleConfigs.git $installdir
if [ ! -d $installdir ]; then
    echo "Failed to clone repo"
    exit 1
else
    cd $installdir
    echo "Running ansible-playbook"
    ansible-playbook -i ./hosts playbook.yml --verbose
fi

echo "Wrapping up..."
rm -Rfv /tmp/$installdir

exit 0
