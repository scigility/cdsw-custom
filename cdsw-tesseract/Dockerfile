# Dockerfile

# CDSW base image
FROM docker.repository.cloudera.com/cdsw/engine:8

RUN apt-get update

# tesseract
RUN apt-get install tesseract-ocr tesseract-ocr-all -y

# dependencies
RUN apt-get install imagemagick libjpeg62 -y
