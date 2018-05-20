1. Creating a blockchain

First we will create a new blockchain named chain1. On the first server, run this command:

multichain-util create chain1

(If you are using Windows, you need to first open a DOS command line in the directory where you installed the MultiChain executables. You can do this by navigating to that directory in the Windows Explorer, then typing cmd in the address bar at the top.)

View the blockchain’s default settings (these can also be modified but we recommend using the defaults for now):

cat ~/.multichain/chain1/params.dat   (on Windows, view %APPDATA%\MultiChain\chain1\params.dat)

Initialize the blockchain, including mining the genesis block:

multichaind chain1 -daemon

You should be told that the server has started and then after a few seconds, that the genesis block was found. You should also be given the node address that others can use to connect to this chain.

Copy and paste the node address here: 

2. Connecting to a blockchain

Now we’ll connect to this blockchain from elsewhere. On the second server, run the following:

multichaind chain1@172.17.0.2:5751

You should be told that the blockchain was successfully initialized, but you do not have permission to connect. You should also be shown a message containing an address in this node’s wallet.

Copy and paste the wallet address here: 

Back on the first server, add connection permissions for this address:

multichain-cli chain1 grant 13yWKC9t6ZdcYfz4hihvKu4QWVsg2STdwWsfom connect

Now try reconnecting again from the second server:

multichaind chain1 -daemon

You should be shown a message that the node was started, and it should display this second node’s address.

3. Some commands in interactive mode

Before we proceed, let’s enter interactive mode so we can issue commands without typing multichain-cli chain1 every time. On both servers:

multichain-cli chain1

(If you are using Windows, interactive mode is not yet available, so all commands in this guide should be preceded by multichain-cli chain1. You will also need to open another DOS command line in the directory where you installed the MultiChain executables.)

Now that the blockchain is working on two nodes, you can run the commands in this section on either or both. To get general information:

getinfo

See a list of all available commands:

help

Show all permissions currently assigned:

listpermissions

Create a new address in the wallet:

getnewaddress

List all addresses in the wallet:

getaddresses

Get the parameters of this blockchain (based on params.dat file):

getblockchainparams

For each node, get a list of connected peers:

getpeerinfo

4. Using native assets

If you only interested in blockchains for data storage and retrieval, rather than representing asset transactions, skip straight to section 6.

Now we are going to create a new asset and send it between nodes. On the first server, get the address that has the permission to create assets:

listpermissions issue

Copy and paste the displayed address here: 

Now we’ll create a new asset on this node with 1000 units, each of which can be subdivided into 100 parts, sending it to itself:

issue 18HED8vRK6c76VMy46mzhKg7UjWKEPGz5juSM4 asset1 1000 0.01

On both servers, verify that the asset named asset1 is listed:

listassets

Now check the asset balances on each server. The first should show a balance of 1000, and the second should show no assets at all:

gettotalbalances

On the first server, now try sending 100 units of the asset to the second server’s wallet:

sendasset 13yWKC9t6ZdcYfz4hihvKu4QWVsg2STdwWsfom asset1 100

You should see an error that the address does not have receive permissions. So it’s time to add receive and send permissions:

grant 13yWKC9t6ZdcYfz4hihvKu4QWVsg2STdwWsfom receive,send

Now try sending the asset again, and it should go through:

sendasset 13yWKC9t6ZdcYfz4hihvKu4QWVsg2STdwWsfom asset1 100

Now check the asset balances on each server, including transactions with zero confirmations. They should be 900 and 100 respectively:

gettotalbalances 0

You can also view the transaction on each node and see how it affected their balances:

listwallettransactions 1

5. Transaction metadata

In this section we’ll create a transaction that sends 125 units of asset1 along with some metadata. On the first server, run:

sendwithdata 13yWKC9t6ZdcYfz4hihvKu4QWVsg2STdwWsfom '{"asset1":125}' 48692066726f6d204d756c7469436861696e21

Copy and paste the displayed transaction ID: 

Now this transaction can be examined on the second server as below:

getwallettransaction ccfc3b23aa52d11f8bb4b8c9b69b4aec90a1051f7db88252dfbc7cf49b9631aa

In the output from this command, you should see the balance field showing the incoming 125 units of asset1 and the data field containing the hexadecimal metadata that was added.

6. Streams

Now let’s create a stream, which can be used for general data storage and retrieval. On the first server:

create stream stream1 false

The false means the stream can only be written to by those with explicit permissions. Let’s see its permissions:

listpermissions stream1.*

So for now, only the first server has the ability to write to the stream, as well as administrate it. Let’s publish something to it, with key key1:

publish stream1 key1 73747265616d2064617461

The txid of the stream item is returned. Now let’s see that the stream is visible on another node. On the second server:

liststreams

(The root stream was in the blockchain by default.) Now we want the second server to subscribe to the stream, then view its contents:

subscribe stream1
liststreamitems stream1

Now we want the second server to be allowed to publish to the stream. On the first server:

grant 13yWKC9t6ZdcYfz4hihvKu4QWVsg2STdwWsfom receive,send
grant 13yWKC9t6ZdcYfz4hihvKu4QWVsg2STdwWsfom stream1.write

Note that the address needs both general send/receive permissions for the blockchain, as well as permission to write to this specific stream. Now let’s publish a couple of items on the second server:

publish stream1 key1 736f6d65206f746865722064617461
publish stream1 key2 53747265616d732052756c6521

Now let’s query the stream’s contents in many different ways. Back on the first server:

subscribe stream1
liststreamitems stream1 (should show 3 items)
liststreamkeys stream1 (2 keys)
liststreamkeyitems stream1 key1 (2 items with this key)
liststreampublishers stream1 (2 publishers)
liststreampublisheritems stream1 13yWKC9t6ZdcYfz4hihvKu4QWVsg2STdwWsfom (2 items by this publisher)

This is just a taste of the ways in which streams can be queried – for more information, please consult the API documentation.

7. Round-robin mining

In this section we’ll start collaborative “mining” (i.e. block creation) between the nodes. Note that mining in the case of a permissioned MultiChain blockchain is based on block signatures and a customizable round-robin consensus scheme, rather than proof-of-work as in bitcoin.

On the first server, run:

grant 13yWKC9t6ZdcYfz4hihvKu4QWVsg2STdwWsfom mine

On the second server, check that two permitted miners are listed:

listpermissions mine

Run this on both servers to maximize the degree of miner randomness:

setruntimeparam miningturnover 1

Now wait for a couple of minutes, so that a few blocks are mined. (This assumes you left the block time on the default of 15 seconds.) On either server, check the miners of the last few blocks:

listblocks -10

The address of the miner of each block is in the miner field of each element of the response.

Note that this tutorial uses only two mining nodes and the low default value for the mining-diversity blockchain parameter. So each block can be mined by either node, and the chain is not secure. A secure chain would use more mining nodes and/or a higher value for this parameter.