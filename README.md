[![docker pulls](https://img.shields.io/docker/pulls/scigilityacademy/cdsw-custom.svg)](https://hub.docker.com/r/scigilityacademy/cdsw-custom/) [![docker stars](https://img.shields.io/docker/stars/scigilityacademy/cdsw-custom.svg)](https://hub.docker.com/r/scigilityacademy/cdsw-custom/) [![image metadata](https://images.microbadger.com/badges/image/scigilityacademy/cdsw-custom.svg)](https://microbadger.com/images/scigilityacademy/cdsw-custom "scigilityacademy/cdsw-custom image metadata") [![Join the chat at https://gitter.im/cdsw-custom/community](https://badges.gitter.im/cdsw-custom/community.svg)](https://gitter.im/cdsw-custom/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

# cdsw-custom

Custom docker image for CDSW based on official Cloudera base image v10 `docker.repository.cloudera.com/cdsw/engine:10`.

Custom configuration compared to the Cloudera base image:

- New installations
    - RStudio v1.2.5033
    - Tesseract v4.1.1
    - Apache Toree kernel v0.3.0 for Jupyter
- Upgrades
    - `python` links to Python 3 as default version
    - `pip` links to Python 3 as default version

Note that this Docker image is designed to be used from CDSW with an existing Cloudera CDH installation:
Some executables like e.g. Java and Spark are not part of the image, but expected to be mounted at runtime by CDSW.

## How To Build

Copy the files from this repository into a directory:

```bash
git clone git@bitbucket.org:scigility/cdsw-custom.git
cd cdsw-custom
```

Copy your **Spark** and **Java** installation to subfolders, so they can be copied to the build context by Docker when building the image:

```bash
# example paths for Spark & Java on default CDH installation - adapt if needed
cp -L -R /opt/cloudera/parcels/CDH/lib/spark spark
cp -L -R usr/lib/jvm/java-openjdk java
```

Build the image, tagging it with a desired tag via `-t` parameter:

```bash
docker build --network=host -t scigilityacademy/cdsw-custom:v42.0alpha . -f Dockerfile
```

Depending on your environment, you might need to include `sudo` before some of the commands.

## CDSW Editor Configuration

To use the installations above, configure the following editors in the CDSW admin console:

- RStudio: `/usr/local/bin/rstudio-cdsw`
- Jupyter Notebook: `/usr/local/bin/jupyter-notebook --no-browser --ip=127.0.0.1 --port=${CDSW_APP_PORT} --NotebookApp.token= --NotebookApp.allow_remote_access=True --log-level=ERROR`

## Tesseract Details

The library _Tesseract_ plus dependencies like _imagemagick_ and _libjpeg62_ are installed when building the image.

You can use Tesseract in two ways:

- Tesseract CLI: Enter `tesseract --help` on the command line for more details
- Via [Apache Tika](https://tika.apache.org/) and Scala/Spark: Add Tika as a library dependency to your Scala program - in a Jupyter notebook e.g. by executing:

```scala
%AddDeps org.apache.tika tika-core 1.22 --transitive
%AddDeps org.apache.tika tika-parsers 1.22 --transitive
```

## CDSW Image Startup Time

If you configure CDSW to pull the image directly from Docker Hub: The first time you start a session, CDSW has to pull the image, which can take quite some time.

## Additional Links

If you need further help for the CDSW setup, head over to Cloudera's excellent documentation: https://docs.cloudera.com/documentation/data-science-workbench/1-7-x/topics/cdsw_editors_browser.html
