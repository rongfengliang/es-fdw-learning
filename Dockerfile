FROM postgres:9.5
RUN apt-get update && apt-get -y install \
        postgresql-9.5-python-multicorn \
        python-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
RUN pip install  pg_es_fdw