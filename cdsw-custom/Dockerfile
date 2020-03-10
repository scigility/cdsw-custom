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



# --- install Tesseract (following instructions from https://orionfoysal.github.io/Installing-Tesseract4.0/)

RUN apt-get install -y g++ autoconf automake libtool autoconf-archive pkg-config libpng-dev libjpeg8-dev libtiff5-dev zlib1g-dev libjpeg62 imagemagick # dependencies
RUN apt-get install -y libicu-dev libpango1.0-dev libcairo2-dev # training tools

RUN wget http://www.leptonica.org/source/leptonica-1.79.0.tar.gz

RUN tar xf leptonica-1.79.0.tar.gz && \
    cd leptonica-1.79.0 && \
    ./configure && \
    make && \
    make install %% \
    cd ..

RUN wget https://github.com/tesseract-ocr/tesseract/archive/4.1.1.tar.gz

RUN tar xf 4.1.1.tar.gz && \
    cd tesseract-4.1.1 && \
    sh autogen.sh  && \
    ./configure  && \
    LDFLAGS="-L/usr/local/lib" CFLAGS="-I/usr/local/include" make  && \
    make install  && \
    make install -langs  && \
    ldconfig && \
    cd ..

# language packs: eng + deu
RUN wget -O /usr/local/share/tessdata/eng.traineddata https://github.com/tesseract-ocr/tessdata/raw/master/eng.traineddata
RUN wget -O /usr/local/share/tessdata/deu.traineddata https://github.com/tesseract-ocr/tessdata/raw/master/deu.traineddata

# remove downloaded sources
RUN rm -rf leptonica-1.79.0.tar.gz
RUN rm -rf leptonica-1.79.0
RUN rm -rf 4.1.1.tar.gz
RUN rm -rf tesseract-4.1.1
