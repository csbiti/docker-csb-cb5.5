FROM python:3.11-slim

# Installer les dépendances du client Oracle et d'autres utilitaires nécessaires
RUN apt-get update && apt-get install -y \
    libaio1 \
    wget \
    unzip \
    gcc \
    libssl-dev \
    build-essential

# Télécharger et installer l'Oracle Instant Client
RUN wget https://download.oracle.com/otn_software/linux/instantclient/instantclient-basiclite-linux.x64-21.10.0.0.0dbru.zip \
    && unzip instantclient-basiclite-linux.x64-21.10.0.0.0dbru.zip \
    && rm instantclient-basiclite-linux.x64-21.10.0.0.0dbru.zip \
    && mv instantclient_21_10 /usr/lib/oracle \
    && echo "/usr/lib/oracle" > /etc/ld.so.conf.d/oracle-instantclient.conf \
    && ldconfig

# Configurer le chemin de la bibliothèque Oracle
ENV LD_LIBRARY_PATH=/usr/lib/oracle

WORKDIR /usr/src/app


RUN pip install --upgrade pip
RUN pip install pyyaml
RUN pip install paramiko
RUN pip install numpy
RUN pip install pandas==1.4.3
RUN pip install unidecode==1.3.8
RUN pip install cx_Oracle
RUN pip install dynaconf
RUN pip install sqlalchemy

