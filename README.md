# cdsw-images

This repository contains some useful custom docker images for the Cloudera Data Science Workbench (CDSW).

## Images

### cdsw-rstudio

Docker image with browser based RStudio for CDSW, based on the official Cloudera documentation.

You can directly use this docker image within your CDSW installation:
- Log in as administrator
- Go to Admin -> Engines
- add _matthiaspfenninger/cdsw-rstudio_ to the list of engines
- click the _Add Editor_ button and add _RStudio_ with the command _/usr/local/bin/rstudio-cdsw_

If you now select this engine in a new project and start a session, a web version of RStudio will start. Have fun!

### cdsw-tesseract

Docker image for CDSW with `tesseract` plus library dependencies `imagemagick` & `libjpeg62` which are needed to do OCR via Apache Tika.

You can use this image in a Jupyter notebook with Apache Toree kernel together with the following imports:
```scala
%AddDeps org.apache.tika tika-core 1.22 --transitive
%AddDeps org.apache.tika tika-parsers 1.22 --transitive
```

### cdsw-custom

Docker image for CDSW with some custom configurations:
- RStudio (based on official Cloudera documentation, see section above for details)
- Tesseract and dependent libraries (loosely following the instructions from [this blog](https://orionfoysal.github.io/Installing-Tesseract4.0/)
- Apache Toree kernel for Jupyter (include `jupyter toree install --spark_home=$SPARK_HOME --user` in your Jupyter editor startup command)

## General Remarks

### CDSW Image Startup Time 

The first time you start a session, CDSW has to pull the image from DockerHub, which can take quite some time (depending on the speed of the internet connection of your CDSW host).

## Additional Links

If you need further help for the CDSW setup, head over to Cloudera's excellent documentation: https://docs.cloudera.com/documentation/data-science-workbench/1-6-x/topics/cdsw_editors_browser.html
