FROM openjdk:8u222-jre-slim

# GIT 
RUN apt-get update && \
    apt-get upgrade -y

WORKDIR /opt/spark_ml/

COPY requirements.txt .

RUN apt install -y python3 python3-pip python3-gi python3-dbus python3-software-properties libpq-dev python3-dev && \
    pip install -r requirements.txt && \
    pip install jupyter notebook && \
    echo "alias notebook='jupyter notebook --ip 0.0.0.0 --port 8888 --allow-root --no-browser'" >> /root/.bashrc

ENTRYPOINT [ "notebook" ]