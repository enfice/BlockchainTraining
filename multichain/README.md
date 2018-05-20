### Install Docker
from: https://www.docker.com/community-edition

### Build Docker Images
Run following command first time to build the node images:
```sh
docker-compose build
```

### Start Docker Images
Run following command to start the node images everytime:
```sh
docker-compose up
```

### Connect to running nodes
```sh
docker ps
```
Copy the CONTAINER ID from the list and then run:
```sh
docker exec -it <container-id-here> bash
```

### One time steps in each node:

On the first node run:
```sh
multichain-util create chain1
multichaind chain1 -daemon
```

Then run:
```sh
nano /root/.multichain/chain1/params.dat
```
copy the rpc-port value for default-rpc-port

then run:
```sh
nano /root/.multichain/chain1/multichain.conf
```
copy the rpcuser & rpcpassword values

then goto /var/www/html/multichain-web-demo/ & run:
```sh
cp config-example.txt config.txt
```

then run:
```sh
nano config.txt
```
in this file update the values for:
default.rpcport
default.rpcuser
default.rpcpassword

### Launch Multichain Web Demo:
On the host machine hit the following URLs to see each nodes web interfaces:

node1: http://localhost:8001/multichain-web-demo/

node2: http://localhost:8002/multichain-web-demo/