echo "STARTING BLOCK EXPLORER container (in background) at localhost:9191"
docker run -d --rm --name alethio-block-explorer -p 9191:80 -e APP_NODE_URL=http://localhost:8545 alethio/ethereum-lite-explorer

echo "STARTING ETHSTATS SERVER containers (in background) at localhost:8080"
cd ext-tools/ethstats-network-server/docker/lite-mode/memory-persistence
docker-compose up -d

echo "STARTING ETHSTATS CLIENTS containers (in background)"
docker run -d --rm --name ethstats-client-br00 --net host alethio/ethstats-cli --register --account-email lvmh@unimib.it --node-name LVMH-00 --server-url http://localhost:3000 --client-url ws://127.0.0.1:9545
docker run -d --rm --name ethstats-client-br01 --net host alethio/ethstats-cli --register --account-email gucci@unimib.it --node-name GUCCI-00 --server-url http://localhost:3000 --client-url ws://127.0.0.1:9546
docker run -d --rm --name ethstats-client-br02 --net host alethio/ethstats-cli --register --account-email prada@unimib.it --node-name PRADA-00 --server-url http://localhost:3000 --client-url ws://127.0.0.1:9547
docker run -d --rm --name ethstats-client-br03 --net host alethio/ethstats-cli --register --account-email armani@unimib.it --node-name ARMANI-00 --server-url http://localhost:3000 --client-url ws://127.0.0.1:9548

echo "PROCEDURE COMPLETED, here's the list"
docker container ls