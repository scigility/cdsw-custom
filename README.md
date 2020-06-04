# cdsw-images

This repository contains some useful custom docker images for the Cloudera Data Science Workbench (CDSW).

## Images

### cdsw-rstudio

Docker image with browser based RStudio for CDSW, based on the official Cloudera documentation.
After building the docker image and adding it to your CDSW instance, add an editor _RStudio_ with the command _/usr/local/bin/rstudio-cdsw_.

### cdsw-tesseract

Docker image for CDSW with `tesseract` plus library dependencies `imagemagick` & `libjpeg62` which are needed to do OCR via Apache Tika.

You can use this image in a Jupyter notebook with Apache Toree kernel together with the following imports:
```scala
%AddDeps org.apache.tika tika-core 1.22 --transitive
%AddDeps org.apache.tika tika-parsers 1.22 --transitive
```

### cdsw-custom

Docker image for CDSW with some custom configurations:
- RStudio (configure RStudio editor with command `/usr/local/bin/rstudio-cdsw` to use it)
- Tesseract and dependent libraries (loosely following the instructions from [this blog](https://orionfoysal.github.io/Installing-Tesseract4.0/))
- Apache Toree kernel for Jupyter (configure Jupyter Notebook editor with command `/usr/local/bin/jupyter-notebook --no-browser --ip=127.0.0.1 --port=${CDSW_APP_PORT} --NotebookApp.token= --NotebookApp.allow_remote_access=True --log-level=ERROR` to use it

Note that this Dockerfile is designed to be used with the external Spark distribution of a Cloudera cluster.
- The Dockerfile must be built inside an existing Spark installation (`[...]/lib/spark`).
- This Spark installation is copied to the build context only to configure Apache Toree, **but is removed from the image again afterwards**. 
- When running the container, Apache Toree expects Spark to be installed under `/opt/cloudera/parcels/CDH/lib/spark` (i.e. that directory must be mounted at runtime).

## General Remarks

### CDSW Image Startup Time 

The first time you start a session, CDSW has to pull the image from DockerHub, which can take quite some time (depending on the speed of the internet connection of your CDSW host).

### Additional Links

If you need further help for the CDSW setup, head over to Cloudera's excellent documentation: https://docs.cloudera.com/documentation/data-science-workbench/1-7-x/topics/cdsw_editors_browser.html
