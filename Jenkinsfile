pipeline {
    agent any
    options {
        disableConcurrentBuilds()
        disableResume()
    }
    parameters {
        string name: 'ENVIRONMENT_NAME', trim: true, defaultValue: "env1"
        password defaultValue: '', description: 'Password to use for MySQL container - root user', name: 'MYSQL_PASSWORD'
        string name: 'MYSQL_PORT', trim: true , defaultValue: "13306"
        string name: 'MYSQL_PASSWORD', trim: true, defaultValue: "toor"
    }
      stages {
        stage('Checkout GIT repository') {
            steps {
              script {
                git branch: 'feature-jenkins',
                credentialsId: 'dfe8230d-dd9b-49df-8ed7-362b17864d2e',
                url: 'git@github.com:arizzi-sandbox/orajen.git'
              }
            }
        }
        stage('Start new container using latest image and create user') {
            steps {     
              script {
                def dateTime = (sh(script: "date +%Y%m%d%H%M%S", returnStdout: true).trim())
                def containerName = "${params.ENVIRONMENT_NAME}_${dateTime}"
                def value = "${params.MYSQL_PORT}"
                /*
                The directory below was fixed because I ran jenkins in using the host docker;
                because that mount point directory must be in the docker host, not in jenkins container
                I think if jenkis is istalled locally or using a agent will be easy to fix this hardcoded session
                */
                def localsqldir_write = (sh(script: "pwd", returnStdout: true);trim())
                def localsqldir = "/home/support/works/orajen-fork/sql"
                sh """
                if [ "$value" -gt 0 ] && [ "$value" -lt 65536 ]; then
                    echo $localsqldir_write
                    docker run -it -d --rm --name ${containerName} -e MYSQL_RANDOM_ROOT_PASSWORD=yes -e MYSQL_USER=developer -e MYSQL_PASSWORD=$params.MYSQL_PASSWORD -e MYSQL_DATABASE=DEVAPP -p $params.MYSQL_PORT:3306 --name $containerName -v $localsqldir:/docker-entrypoint-initdb.d mysql

                    echo "Docker container name $containerName created: mysql://developer@<docker_host_ip>:$params.MYSQL_PORT/"
                else
                    echo "TCP port out of range: $value"
                    exit 1
                fi
                """

              }
            }
        }
    }
}
