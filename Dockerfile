FROM iconloop/tbears:1.6.4


#Build and configure Daedric
COPY . /Daedric
#RUN git clone https://github.com/skirillex/Daedric.git /Daedric
RUN apt-get update && apt-get install -y jq \
    cron
RUN pip install requests==2.22.0

WORKDIR /Daedric
#RUN ./start_tbears.sh
#RUN ./install.sh
# obtain testnet ICX for the newly generated testnet (yeouido) wallet
#RUN python ./get_testnet_icx.py
#RUN sleep 10
# insert password into testnet (yeouido) tbears_cli_config.json file
#RUN python ./insert_testnet_password.py \
#    && ./scripts/score/deploy_score.sh -n yeouido -t ICXUSD

#RUN ./scripts/score/deploy_score.sh -n yeouido -t ICXUSD
# quick tests
#RUN ./scripts/bots/equalizer/icxusd/post.sh -n yeouido
#RUN ./scripts/score/post.sh -n yeouido -p 10000000000000000000
#RUN ./scripts/score/peek.sh -n yeouido

#RUN echo "Score Address:" && cat ./config/yeouido/score_address.txt

COPY entry.sh /usr/local/bin/entry.sh
RUN chmod +x /usr/local/bin/entry.sh



ENTRYPOINT ["entry.sh"]