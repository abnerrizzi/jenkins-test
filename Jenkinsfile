pipeline {
    agent any
    options {
        disableConcurrentBuilds()
        disableResume()
    }
    parameters {
        string name: 'ENVIRONMENT_NAME', trim: true, defaultValue: "env1"
        password defaultValue: '', description: 'Password to use for MySQL container - root user', name: 'DB_PASSWORD'
        string name: 'DB_PORT', trim: true , defaultValue: "13306"
        string name: 'DB_PASSWORD', trim: true, defaultValue: "toor"
        choice name: 'DB_TYPE', choices: "mysql\npostgres\noracle"
    }
      stages {
        stage('Checkout GIT repository') {
            steps {
              script {
                git branch: 'feature-jenkins',
                url: 'https://github.com/arizzi-sandbox/orajen.git'
              }
            }
        }

        stage('Start new container using latest image and create user') {
            steps {     
              script {
                def dateTime = (sh(script: "date +%Y%m%d%H%M%S", returnStdout: true).trim())
                def containerName = "${params.ENVIRONMENT_NAME}_${dateTime}"
                def db_port = "${params.DB_PORT}"
                def db_type = "${params.DB_TYPE}"
                /*
                The directory below was fixed because I ran jenkins in using the host docker;
                because that mount point directory must be in the docker host, not in jenkins container
                I think if jenkis is istalled locally or using a agent will be easy to fix this hardcoded session
                */
                def localsqldir_write = (sh(script: "pwd", returnStdout: true).trim())
                def localsqldir = "/home/support/works/orajen-fork/sql"

                /*
                #if [ \"$params.DB_TYPE\" == \"mysql\" ]; then
                #    docker run -it -d --rm --name ${containerName} -e MYSQL_RANDOM_ROOT_PASSWORD=yes -e MYSQL_USER=developer -e MYSQL_PASSWORD=$params.DB_PASS -e MYSQL_DATABASE=DEVAPP -p $params.DB_PORT:3306 --name $containerName -v $localsqldir:/docker-entrypoint-initdb.d mysql
                #elif [ \"$params.DB_TYPE\" == \"postgres\" ]; then
                #    docker run -it -d --rm --name ${containerName} -e POSTGRES_USER=developer -e POSTGRES_PASSWORD=$params.DB_PASS -e POSTGRES_DB=DEVAPP -p $params.DB_PORT:5432 --name $containerName -v $localsqldir:/docker-entrypoint-initdb.d postgres
                #elif [ \"$params.DB_TYPE\" == \"oracle\" ]; then
                #    docker run -it -d --rm --name ${containerName} -e ORACLE_USER=developer -e ORACLE_PASSWORD=$params.DB_PASS -e ORACLE_DB=DEVAPP -p $params.DB_PORT:1521 --name $containerName -v $localsqldir/oracle:/docker-entrypoint-initdb.d container-registry.oracle.com/database/express:latest
                #fi
                */

                if (params.DB_TYPE.contains('mysql')) {
                    sh """
                    docker run -it -d --rm --name ${containerName} -e MYSQL_RANDOM_ROOT_PASSWORD=yes -e MYSQL_USER=developer -e MYSQL_PASSWORD=$params.DB_PASS -e MYSQL_DATABASE=DEVAPP -p $params.DB_PORT:3306 --name $containerName -v $localsqldir/${db_type}:/docker-entrypoint-initdb.d mysql
                    """
                } else if (params.DB_TYPE.contains('postgres')) {
                    sh """
                    docker run -it -d --name ${containerName} -e POSTGRES_USER=developer -e POSTGRES_PASSWORD=$params.DB_PASS -e POSTGRES_DB=DEVAPP -p $params.DB_PORT:5432 --name $containerName -v $localsqldir/${db_type}:/docker-entrypoint-initdb.d postgres
                    """
                } else if (params.DB_TYPE.contains('oracle')) {
                    sh """
                    echo docker run -it -d --name ${containerName} -e ORACLE_USER=developer -e ORACLE_PASSWORD=$params.DB_PASS -e ORACLE_DB=DEVAPP -p $params.DB_PORT:1521 --name $containerName -v $localsqldir/${db_type}/oracle:/docker-entrypoint-initdb.d container-registry.oracle.com/database/express:latest"""
                } else {
                    sh """ Unexpected error """
                    exit 1
                }
              }
            }
        }
    }
}
