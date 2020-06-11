FROM iconloop/tbears:mainnet


#Build and configure Daedric
RUN git clone https://github.com/skirillex/Daedric.git /Daedric
RUN apt-get update && apt-get install -y jq
RUN pip install requests==2.22.0
WORKDIR /Daedric
RUN ./start_tbears.sh
RUN ./install.sh
RUN ./install.sh
RUN python ./get_testnet_icx.py
RUN sleep 10
RUN python ./insert_testnet_password.py

RUN cat ./config/yeouido/tbears_cli_config.json


RUN ./scripts/score/deploy_score.sh -n yeouido -t ICXUSD
RUN ./scripts/bots/equalizer/icxusd/post.sh -n yeouido
RUN cat ./config/yeouido/score_address.txt


ENTRYPOINT ["entry.sh"]