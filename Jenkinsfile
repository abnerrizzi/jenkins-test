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
                def portNumber = "${params.MYSQL_PORT}"
                if ($portNumber >= 0 && $portNumber <= 65535) {
                  def dateTime = (sh(script: "date +%Y%m%d%H%M%S", returnStdout: true).trim())
                  def containerName = "${params.ENVIRONMENT_NAME}_${dateTime}"
                  sh """
                  docker run -it -d --rm --name ${containerName} -e MYSQL_RANDOM_ROOT_PASSWORD=yes -e MYSQL_USER=developer -e MYSQL_PASSWORD=$params.MYSQL_PASSWORD -e MYSQL_DATABASE=DEVAPP -p $params.MYSQL_PORT:3306 --name $containerName mysql
                  """

                  echo "Docker container name $containerName created: mysql://developer@<docker_host_ip>:$params.MYSQL_PORT/"
                } else {
                  error ("Port is not valid. Please enter a valid port number between 0 and 65535")
                }
              }
            }
        }
    }
}
