# ALA Sensitive Data Service

## Setup

### Config and data directory
Create data directory `/data/ala-sensitive-data-service` and populate as below (it is easiest to symlink the config files to the ones in this repo):

```
$ tree /data/ala-sensitive-data-service
/data/ala-sensitive-data-service/
└── config
    └── config.yml -> /home/manash/projects/ala-sensitive-data-service/sbdi/data/ala-sensitive-data-service/config/config.yml
```

This application requires folder structure and config files that are also used by the `sds-webapp2` application so ensure the folder `/data/sds` exists with the following files and folder structure.

```
$ tree /data/sds/
/data/sds/
└── config
    └── sds-config.properties -> /home/manash/projects/ala-sensitive-data-service/sbdi/data/sds/config/sds-config.properties
```
### Index
The service requires a taxonomic search index (Lucene) at /data/lucene/namematching

## Usage
### Run locally:
```
make run
```

### Build and run in Docker (using Tomcat).

```
make run-docker
```

### Make a release. This will create a new tag and push it. A new Docker image will be built on Github.
```
$ make release
Current version: 1.0.1. Enter the new version (or press Enter for 1.0.2): 
Updating to version 1.0.2
Tag 1.0.2 created and pushed.

```
