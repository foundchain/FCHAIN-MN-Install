#/bin/bash

cd ~
  
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
sudo apt-get install -y nano htop git
sudo apt-get install -y software-properties-common
sudo apt-get install -y build-essential libtool autotools-dev pkg-config libssl-dev
sudo apt-get install -y libboost-all-dev
sudo apt-get install -y libevent-dev
sudo apt-get install -y libminiupnpc-dev
sudo apt-get install -y autoconf
sudo apt-get install -y automake unzip
sudo add-apt-repository  -y  ppa:bitcoin/bitcoin
sudo apt-get update
sudo apt-get install -y libdb4.8-dev libdb4.8++-dev
sudo apt-get install libzmq3-dev

cd /var
sudo touch swap.img
sudo chmod 600 swap.img
sudo dd if=/dev/zero of=/var/swap.img bs=1024k count=2000
sudo mkswap /var/swap.img
sudo swapon /var/swap.img
sudo free
sudo echo "/var/swap.img none swap sw 0 0" >> /etc/fstab
cd

wget https://github.com/foundchain/FCHAIN/releases/download/1.0.0/fchain-1.0.0-x86_64-linux-gnu.tar.gz
tar -xzf fchain-1.0.0-x86_64-linux-gnu.tar.gz

sudo apt-get install -y ufw
sudo ufw allow ssh/tcp
sudo ufw limit ssh/tcp
sudo ufw logging on
echo "y" | sudo ufw enable
sudo ufw status
sudo ufw allow 6565/tcp
  
cd
mkdir -p .fchain
echo "staking=1" >> fchain.conf
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> fchain.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> fchain.conf
echo "rpcallowip=127.0.0.1" >> fchain.conf
echo "listen=1" >> fchain.conf
echo "server=1" >> fchain.conf
echo "daemon=1" >> fchain.conf
echo "logtimestamps=1" >> fchain.conf
echo "maxconnections=256" >> fchain.conf
echo "port=6565" >> fchain.conf
mv fchain.conf .fchain

  
cd
./fchaind -daemon
sleep 30
./fchain-cli getinfo
sleep 5
./fchain-cli getnewaddress
echo "Use the address above to send your FCHAIN coins to this server"
