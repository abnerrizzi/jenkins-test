-----
# Solution
I have never worked implementing or creating a new pipeline on Jenkins before, only supporting it was my first time.
So I create a docker-compose to start a jenkins container with a custom imagem that add docker to jenkins image and allow to runs the docker of the host through mounted point.

Because that Jenkins was unable do run ```docker run -v <jenkins_folder>:/container folder```. As I am using docker inside a container, when we start a container the docker is looking for a file in host, not inside the jenkins container, to fix that I hardcoded the path of my docker host.

I tried to be concise.

# Observations and recommendations
[FIX]es:
- docker build process removed (unnedded step waisting time and resources)


To implement the optional features will require the following steps:
- basic mysql and postgres was tested
- for oracle I didnt have enough space and ram to validate and develop a script to create a database and populate it.




# Welcome

## Overview

This archive contains files for our basic Jenkins pipeline to automatically create MySQL database instance - running on Docker, so our developers can have their very own environment to use.

This archive contains all the files being used by the current version of the pipeline.

```
|-- Dockerfile
|-- build-dev-environment.groovy
`-- include
    `-- create_developer.template
```

## Preparation

- Please upload your solution to GitHub into a public repository and share the URL in reply e-mail

## Expected behaviour

- Developers can trigger the pipeline with parameters (Environment name, MySQL password and MySQL port)
- A docker image built from latest MySQL image
- Spin up a container from the image built above, exposing the requested port on the Docker host
- Prepare the environment by creating an account for the developer (username: developer, password: based on input parameter)

## Issues

- The pipeline fails randomly in Jenkins
- If it works, developers are still not able to login into the running MySQL container because of an unknown issue. Please fix these issue before moving to the next part.

## Further improvement requests

- Pipeline should fail if the MySQL port parameter is not a valid number within port range
- Developers would also need a table called "departments" under the "DEVAPP" database with the following columns and with some demo data populated
    - DEPT - number 4 digit
    - DEPT_NAME - varchar 250
- Please share any observation / recommendation you might have on this process

## Optional
- Extend the pipeline with ability to switch database engine and implement the same scope using either:
    - [OracleXE](https://container-registry.oracle.com/ords/f?p=113:4:3559407972469:::4:P4_REPOSITORY,AI_REPOSITORY,AI_REPOSITORY_NAME,P4_REPOSITORY_NAME,P4_EULA_ID,P4_BUSINESS_AREA_ID:803,803,Oracle%20Database%20Express%20Edition,Oracle%20Database%20Express%20Edition,1,0&cs=3DRUVeYjFotraARk1_SIQT-gpXHdclgNeRODkR0y5bUs8pMZHRZgRESapOWM2F4DJVgxuFhP_eLjQZFewWuqYRw)
    OR
    - [PostgreSQL](https://hub.docker.com/_/postgres/)