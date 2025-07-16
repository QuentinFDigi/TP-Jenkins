pipeline {
    agent any
    environment {
        port = "8080"
        container = "docker-with-jenkins"
        image = "basic-site"
    }
    stages { 
        stage("build") {
            steps {
                script {
                    sh "ls"
                    sh "docker build -t ${image} ."
                }
            }
        }
        stage("run") {
            steps {
                sh "docker run -p ${port}:80 ${image}"
            }
        }
        stage("stop") {
            steps {
                script {
                    def result = sh(
                        script: "docker ps -a --filter 'name=${container}' --format '{{.Names}}'",
                        returnStdout: true
                    ).trim()

                    if (result == ${container}) {
                        sh "docker stop ${container}"
                        sh "docker rm ${container}"
                    }
                }
            }
        }
        stage("deploy") {
            steps {
                sh "docker run -d -p ${port}:80 --name ${container} ${image}"
            }
        }
    }
    post {
        success {
            echo "Site deployé sur le port ${port}"
        }
        failure {
            echo "Site non déployé"
        }
    }
}
