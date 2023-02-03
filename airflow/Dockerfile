FROM apache/airflow:2.4.0
USER root
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
         build-essential libopenmpi-dev \
  && apt-get autoremove -yqq --purge \
  && apt-get clean \
  && apt install unixodbc-dev \
  && rm -rf /var/lib/apt/lists/*

USER airflow
RUN pip install apache-airflow-providers-microsoft-mssql
