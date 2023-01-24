FROM ubuntu:20.04

USER root
# Install OpenJDK-11, Firefox and Dependencies
RUN apt update && \
    apt-get install -y && \
    apt-get -y install wget curl && \
    apt-get install -y openjdk-11-jdk && \
    apt-get install -y ant && \
    apt-get install -y unzip && \
    apt-get install -y gcc && \
    apt-get install -y libxml2-dev && \
    apt-get install -y libxslt1-dev && \
    apt-get install -y zlib1g-dev && \
    apt-get install -y g++ && \
    apt-get install -y libkrb5-dev && \
    apt-get install -y python3-pip && \
    apt-get -y install cmake && \
    apt-get clean;

WORKDIR /opt/spark-ml
COPY ./requirements.txt /opt/spark-ml/requirements.txt

RUN python3 -m pip install --upgrade pypi && \
    pip install --trusted-host pypi.python.org --no-cache-dir -r requirements.txt && \
    pip install --upgrade jupyter && \
    pip install --upgrade --user nbconvert


# Set JAVA_HOME
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/
RUN export JAVA_HOME
RUN echo "alias notebook='jupyter notebook --ip 0.0.0.0 --port 8888 --allow-root --no-browser'" >> /root/.bashrc

ENTRYPOINT [ "bash" ]