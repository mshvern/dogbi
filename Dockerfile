FROM python:3.6

RUN apt-get -y update
RUN apt-get install -y --fix-missing \
    build-essential \
    cmake \
    gfortran \
    git \
    wget \
    curl \
    graphicsmagick \
    libgraphicsmagick1-dev \
    libatlas-base-dev \
    libavcodec-dev \
    libavformat-dev \
    libgtk2.0-dev \
    libjpeg-dev \
    liblapack-dev \
    libswscale-dev \
    pkg-config \
    python3-dev \
    python3-numpy \
#    software-properties-common \
    zip \
    && apt-get clean && rm -rf /tmp/* /var/tmp/*

RUN cd ~ && \
    mkdir -p dlib && \
    git clone -b 'v19.9' --single-branch https://github.com/davisking/dlib.git dlib/ && \
    cd  dlib/ && \
    python3 setup.py install --yes USE_AVX_INSTRUCTIONS


ADD requirements.txt /requirements.txt
RUN pip install -r requirements.txt

ADD . /
EXPOSE 8000
EXPOSE 8080
RUN python telegram_bot/config.py
ENTRYPOINT python manage.py collectstatic && python manage.py migrate && \
    twistd web --port "tcp:port=8080" --path AI/static --logfile=logtwistd && \
    gunicorn -b 0.0.0.0:8000 dog_bot.wsgi