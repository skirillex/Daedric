#! /bin/bash -

network=yeoudio
while getopts ":n:p:" opt; do
  case $opt in
    n) network="$OPTARG"
    ;;
    p) path_out="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done
./start_tbears.sh
./install.sh

## for docker use docker -v path/to/file:path/to/docker 
## the keystore file should be in the mount point directory
cp /Daedric/config/mainnet/keystores/operator.icx /Daedric/config/mainnet/keystores/operator.icx.original
cp /Daedric/config/mainnet/keystores/operator.password.txt /Daedric/config/mainnet/keystores/operator.password.txt.original
rm /Daedric/config/mainnet/keystores/operator.password.txt
rm /Daedric/config/mainnet/keystores/operator.icx

cp $(grep -r "address" /Daedric/mainnet | cut -d: -f1) /Daedric/config/mainnet/keystores/operator.icx
echo "$path_out" > /Daedric/config/mainnet/keystores/operator.password.txt


if [ $network = mainnet ]
then
  cp 
  sleep 10
fi

if [ $network = yeoudio ]
then
  python ./get_testnet_icx.py
  sleep 10
fi

if [ $network = mainnet ]
then
# the python file below does not exist yet
  python ./insert_mainnet_password.py \
    && ./scripts/score/deploy_score.sh -n mainnet -t ICXUSD
# have it print the score address! or some tracking of it maybe instructions from github
else
  python ./insert_testnet_password.py \
    && ./scripts/score/deploy_score.sh -n yeouido -t ICXUSD
fi

if [ $network = mainnet ]
then
  cp /Daedric/config/mainnet/score_address.txt /Daedric/mainnet
else
  echo "Score Address:" && cat /Daedric/config/yeouido/score_address.txt
fi

service rabbitmq-server start

tbears genconf
tbears start

exec /bin/bash
