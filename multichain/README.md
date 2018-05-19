One time steps after docker-compose up

on the first node run:
multichaind chain1 -daemon

then run 
nano /root/.multichain/chain1/params.dat
copy the rpc-port value for default-rpc-port

then run 
nano /root/.multichain/chain1/multichain.conf
copy the rpcuser & rpcpassword values

then goto /var/www/html/multichain-web-demo/
run
cp config-example.txt config.txt
then run
nano config.txt
in this file update the values for:
default.rpcport
default.rpcuser
default.rpcpassword
