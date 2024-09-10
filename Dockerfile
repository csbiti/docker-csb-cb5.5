FROM python:3.10-slim

# Set environment variables for Oracle client installation
ENV ORACLE_HOME=/usr/lib/oracle/21/instantclient_21_14
ENV LD_LIBRARY_PATH=$ORACLE_HOME
ENV PATH=$ORACLE_HOME:$PATH

# Install required packages for Oracle client
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        unzip \
        wget \
        libaio1 \
        libaio-dev \
        vim \
    && rm -rf /var/lib/apt/lists/*

# Create the Oracle Instant Client directory
RUN mkdir -p $ORACLE_HOME

# Download and install Oracle Instant Client
WORKDIR $ORACLE_HOME
RUN wget https://download.oracle.com/otn_software/linux/instantclient/2114000/instantclient-basic-linux.x64-21.14.0.0.0dbru.zip \
    && unzip instantclient-basic-linux.x64-21.14.0.0.0dbru.zip -d /usr/lib/oracle/21 \
    && rm instantclient-basic-linux.x64-21.14.0.0.0dbru.zip

RUN pip uninstall -y numpy pandas
RUN pip install --upgrade pip
RUN pip install pyyaml
RUN pip install paramiko
RUN pip install numpy==1.24.0
RUN pip install pandas==1.5.3
RUN pip install unidecode==1.3.8
RUN pip install cx_Oracle
RUN pip install dynaconf
RUN pip install sqlalchemy
RUN pip install openpyxl

