#!/bin/bash

#export BLOCK_SIGNER_KEY=dae1a9bffa1a808d3e957fdec61e0979e412206bde948d0e29d925acada9ad82
#export BLOCK_SIGNER_ADDRESS=0xbb8227fc9e5716d12f4b4eea18ac2b188cf19851
echo "Importing private key"
echo $BLOCK_SIGNER_KEY > key.prv
echo "pwd" > password
geth account import --password ./password ./key.prv

# initialize the geth node with the genesis file
echo "Initializing Geth node"
geth  "$@" init /root/genesis.json

geth \
  --password ./password \
  --allow-insecure-unlock \
  --unlock $BLOCK_SIGNER_ADDRESS \
  --mine \
  --gcmode archive \
  --nodiscover \
  --networkid 85643456 \
  -http --http.addr 0.0.0.0 --http.port 8545 \
  --http.corsdomain "*" \
  --http.api "eth,net,web3" \
  --miner.etherbase $BLOCK_SIGNER_ADDRESS \
  "$@"
