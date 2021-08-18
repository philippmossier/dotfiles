# Install python from source , like a pro :-)

**Note: Maybe there are some errors, would not recommend implementing this, this file is just for reference. I would recommend update python with a ppa package manager like deadsnakes**

## Recommended PPA Version

```bash
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update && sudo apt upgrade
sudo apt install python3.9 python3.9-dev python3.9-venv
```

Make sure the associated pip is installed for your user environment:

```bash
python3.9 -m ensurepip --default-pip --user
```

Once I've gone through the steps above I first test pip by trying to upgrade it with the "--user" flag:

```bash
python3.9 -m pip install --upgrade pip --user
```

- uninstall python3.9 (after uninstall, ubuntu uses preinstalled python 3.8)

```bash
sudo apt remove --autoremove python3.9 python3.9-minimal
```

## Install python from source (not recomended)

I used some inputs from:
reference link <https://realpython.com/installing-python/>
(on the bottom on "how to install python from source" part)

Another good ressource for installing from source (especially when u mess up with "update-alternatives" or symlinks):
<https://ubuntuhandbook.org/index.php/2020/10/python-3-9-0-released-install-ppa-ubuntu/>

## bash commands

cd
mkdir localpython
cd localpython
curl <https://www.python.org/ftp/python/3.9.6/Python-3.9.6.tgz> > Python-3.9.6.tgz
tar -zxvf Python-3.9.6.tgz
cd Python-3.9.6

## config before installation (without --prefix the binary gets installed to /usr/local/bin/)

./configure --enable-optimizations --with-ensurepip=install

## use prefix if you want to install it on custom path

./configure --prefix=${HOME}/localpython --enable-optimizations
./configure --enable-optimizations --with-ensurepip=install --prefix=/your/custom/installation/path

## usr/bin would be a good directory aswell

./configure --enable-optimizations --with-ensurepip=install --prefix=/usr/bin

## compile installation (j just means that make runs in parallel threads)

make -j 8

## make sure you have all of the build requirements installed

## For apt-based systems (like Debian, Ubuntu, and Mint)

sudo apt-get install -y build-essential libssl-dev zlib1g-dev libbz2-dev \\
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \\
xz-utils tk-dev libffi-dev liblzma-dev python-openssl git

## if you already have one of this packages it does not matter because they do not get overwritten

## since we have all to install python run make install (altinstall if we have a older python version installed)

sudo make altinstall

## Now python should be succesfully installed

## verify installation

python3.9 --version
python3.9 -m test ## just if you have extra time

## verify pip version

pip --version

## check current pip version you have installed with --with-ensurepip=install , wich got installed under /usr/local/lib/python3.9/site-packages/pip

python3.9 -m pip --version

## upgrade pip command to this version

python3.9 -m pip install --upgrade --force pip

## sometimes pip gets upgraded to even newer version, so python3.9 -m pip --version changed also

## pip with the newest version should work Now

pip --version
pip3 --version ## should also work and be the same version

## since we have installed python3.9 with 'make altinstall' we have to switch to our new version

sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1
sudo update-alternatives --install /usr/bin/python3 python3 /usr/local/bin/python3.9 2

## we have to to this for python and python3 command

sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.8 1
sudo update-alternatives --install /usr/bin/python python /usr/local/bin/python3.9 2

## or easier with which

sudo update-alternatives --install /usr/bin/python python $(which python3.8) 1
sudo update-alternatives --install /usr/bin/python python $(which python3.9) 2

## Note whats the difference between brackets in bash: <https://dev.to/rpalo/bash-brackets-quick-reference-4eh6>
