FROM iconloop/tbears:mainnet


#Build and configure Daedric
RUN git clone https://github.com/skirillex/Daedric.git /Daedric
RUN apt-get update && apt-get install -y jq

WORKDIR /Daedric
RUN ./start_tbears.sh
RUN ./install.sh


ENTRYPOINT ["entry.sh"]