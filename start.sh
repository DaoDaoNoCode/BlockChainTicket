# 解析bootnode地址
bootnode_addr=enode://31214e0f1bb831e9ee2876ff9e4e5a56d2533d75f631a7028038a4611c4e5126bb2981cdc38114e2c9ef49c3fe43396a9f200fd851bfe4e2164762986a72b5e7@120.41.134.169:12345
if [ "$1" == "" ];then
    echo "node id is empty, please use: start.sh <node_id>";
    exit
fi
no=$1
datadir=./
mkdir -p $datadir
# 如果启动前需要使用创世块初始化
if [ ! -d "$DIRECTORY" ]; then
    if [ ! -f $datadir/genesis ];then
        echo '{"config": {"chainId": 15, "homesteadBlock": 0, "eip155Block": 0, "eip158Block": 0 }, "coinbase" : "0x0000000000000000000000000000000000000000", "difficulty" : "0x40000", "extraData" : "", "gasLimit" : "0xffffffff", "nonce" : "0x0000000000000042", "mixhash" : "0x0000000000000000000000000000000000000000000000000000000000000000", "parentHash" : "0x0000000000000000000000000000000000000000000000000000000000000000", "timestamp" : "0x00", "alloc": { } }' > $datadir/genesis
    fi
    geth --datadir $datadir/$no init $datadir/genesis
fi
# 运行geth，启动console
geth --datadir $datadir/$no --networkid 11100 --ipcdisable --port 619$no --rpc --rpccorsdomain "*" --rpcport 81$no --bootnodes $bootnode_addr console
