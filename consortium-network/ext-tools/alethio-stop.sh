echo "STOPPING BLOCK EXPLORER container with docker stop alethio-block-explorer"
docker stop alethio-block-explorer

echo "STOPPING ETHSTATS SERVER with docker-compose down -v"
cd ext-tools/ethstats-network-server/docker/lite-mode/memory-persistence
docker-compose down -v

echo "STOPPING ETHSTATS CLIENTS with docker stop ethstats-client-xx"
docker stop ethstats-client-br00
docker stop ethstats-client-br01
docker stop ethstats-client-br02
docker stop ethstats-client-br03
docker stop ethstats-client-prl00
docker stop ethstats-client-cagXX