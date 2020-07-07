#Dockerfile

FROM docker.repository.cloudera.com/cdsw/engine:10

WORKDIR /tmp


# --- install RStudio

RUN apt-get update && apt-get dist-upgrade -y && \
    apt-get install -y --no-install-recommends \
    libclang-dev \
    lsb-release \
    psmisc \
    libapparmor1 \
    sudo

RUN wget https://download2.rstudio.org/server/trusty/amd64/rstudio-server-1.2.5033-amd64.deb && \
    dpkg -i rstudio-server-1.2.5033-amd64.deb

COPY rstudio-config/rserver.conf /etc/rstudio/rserver.conf

COPY rstudio-config/rstudio-cdsw /usr/local/bin/rstudio-cdsw

RUN chmod +x /usr/local/bin/rstudio-cdsw


# --- install Toree Kernel for Jupyter

COPY ./spark /opt/cloudera/parcels/CDH/lib/spark
RUN pip install --upgrade pip && \
    pip install --no-cache-dir --upgrade toree
RUN jupyter toree install --sys-prefix --spark_home=/opt/cloudera/parcels/CDH/lib/spark
RUN rm -rf /opt/cloudera


# --- install Tesseract

RUN apt-get install -y g++ autoconf automake libtool autoconf-archive pkg-config libpng-dev libjpeg8-dev libtiff5-dev zlib1g-dev libjpeg62 imagemagick # dependencies
RUN apt-get install -y libicu-dev libpango1.0-dev libcairo2-dev # training tools

RUN add-apt-repository ppa:alex-p/tesseract-ocr && \
    apt-get update && \
    apt-get install -y libleptonica-dev tesseract-ocr tesseract-ocr-eng tesseract-ocr-deu && \
    ldconfig

RUN apt-get -y clean && apt-get -y autoclean # cleanup


# --- set python3 as default Python version (also for pip)

RUN ln -s -f /usr/local/bin/python3 /usr/local/bin/python && \
    ln -s -f /usr/bin/python3 /usr/bin/python && \
    ln -s -f /usr/local/bin/pip3.6 /usr/local/bin/pip3 && \
    ln -s -f /usr/local/bin/pip3.6 /usr/local/bin/pip

RUN pip install --upgrade pip # make sure main pip version is up-to-date
