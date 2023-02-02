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

        booleanParam(name: 'SKIP_STEP_1', defaultValue: false, description: 'STEP 1 - RE-CREATE DOCKER IMAGE')
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
                sh """
                docker run -itd --name ${containerName} --rm -e MYSQL_USER=developer -e MYSQL_PASSWORD=$params.MYSQL_PASSWORD -e MYSQL_DATABASE=DEVAPP -p $params.MYSQL_PORT:3306 --name $params.ENVIRONMENT_NAME mysql
                """

                echo "Docker container created: mysql://developer@<docker_host_ip>:$params.MYSQL_PORT/"

              }
            }
        }
    }
}
