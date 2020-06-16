#! /bin/bash -

network=yeoudio
while getopts ":n:k:" opt; do
  case $opt in
    n) network="$OPTARG"
    ;;
    k) path_out="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

service rabbitmq-server start

tbears genconf
tbears start

./start_tbears.sh
./install.sh



## for docker use docker -v path/to/file:/Daedric/mainnet
## the keystore file should be in the mount point directory

if [ $network = mainnet ]
then
  # configures Daedric to use included keystore file + password
  cp /Daedric/config/mainnet/keystores/operator.icx /Daedric/config/mainnet/keystores/operator.icx.original
  cp /Daedric/config/mainnet/keystores/operator.password.txt /Daedric/config/mainnet/keystores/operator.password.txt.original
  rm /Daedric/config/mainnet/keystores/operator.password.txt
  rm /Daedric/config/mainnet/keystores/operator.icx

  cp $(grep -r "address" /Daedric/mainnet | cut -d: -f1) /Daedric/config/mainnet/keystores/operator.icx
  echo "$path_out" > /Daedric/config/mainnet/keystores/operator.password.txt
fi

if [ $network = yeoudio ]
then
  python ./get_testnet_icx.py
  sleep 10
fi

if [ $network = mainnet ]
then
# deploy to mainnet
  python ./insert_mainnet_password.py \
    && ./scripts/score/deploy_score.sh -n mainnet -t ICXUSD

else
# deploy to testnet
  python ./insert_testnet_password.py \
    && ./scripts/score/deploy_score.sh -n yeouido -t ICXUSD
fi

if [ $network = mainnet ]
then
# copy over the deployed score address to mounted volume
  cp /Daedric/config/mainnet/score_address.txt /Daedric/mainnet
else
  echo "#######################################################"
  echo "####   Score Address:" && cat /Daedric/config/yeouido/score_address.txt
  echo " "
  echo "#######################################################"
fi



exec /bin/bash
