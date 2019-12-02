# docker-images

This repository contains some useful custom docker images.

## cdsw-rstudio

Docker image with browser based RStudio for CDSW, based on the official Cloudera documentation.
The tags used in DockerHub refer to the RStudio Server version, while _latest_ is the version recommended in the Cloudera documentation.

You can directly use this docker image within your CDSW installation:
- Log in as administrator
- Go to Admin -> Engines
- add _matthiaspfenninger/cdsw-rstudio_ to the list of engines
- click the _Add Editor_ button and add _RStudio_ with the command _/usr/local/bin/rstudio-cdsw_

If you now select this engine in a new project and start a session, a web version of RStudio will start. Have fun!

_Beware: The first time you start a session, CDSW has to pull the image from DockerHub, which can take quite some time (depending on the speed of the internet connection of your CDSW host)!_

## cdsw-tesseract

Docker image with `tesseract` and `imagemick` libraries preinstalled for OCR.


### Additional Links

If you need further help, head over to Cloudera's excellent documentation: https://docs.cloudera.com/documentation/data-science-workbench/1-6-x/topics/cdsw_editors_browser.html