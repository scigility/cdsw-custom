# Dockerfile

# CDSW base image
FROM docker.repository.cloudera.com/cdsw/engine:8

RUN apt-get update

# tesseract
RUN apt-get install tesseract-ocr -y
RUN apt-get install tesseract-ocr-all -y

# dependencies
RUN apt install imagemagick -y
RUN apt-get install libjpeg62 -y