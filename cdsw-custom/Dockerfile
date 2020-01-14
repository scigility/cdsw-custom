#Dockerfile

FROM docker.repository.cloudera.com/cdsw/engine:8

WORKDIR /tmp


# --- install RStudio

RUN apt-get update && apt-get dist-upgrade -y && \
    apt-get install -y --no-install-recommends \
    libclang-dev \
    lsb-release \
    psmisc \
    sudo

RUN wget https://download2.rstudio.org/server/trusty/amd64/rstudio-server-1.2.1335-amd64.deb && \
    dpkg -i rstudio-server-1.2.1335-amd64.deb

COPY rserver.conf /etc/rstudio/rserver.conf

COPY rstudio-cdsw /usr/local/bin/rstudio-cdsw

RUN chmod +x /usr/local/bin/rstudio-cdsw


# --- install Toree Kernel for Jupyter

RUN pip install --no-cache-dir --upgrade toree
# be sure to include 'jupyter toree install --spark_home=$SPARK_HOME --user' in your Jupyter startup command


# --- install Tesseract and dependencies

RUN apt-get install tesseract-ocr tesseract-ocr-all imagemagick libjpeg62 -y
