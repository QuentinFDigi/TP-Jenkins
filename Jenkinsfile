pipeline {
    agent { label 'agent-linux' }
    environment {
        port = "8080"
        container = "docker-with-jenkins"
        image = "basic-site"
    }
    stages { 
        stage("build") {
            steps {
                sh "ls"
                sh "docker build -t ${image} ."
            }
        }
        stage("stop") {
            steps {
                script {
                    sh "docker stop ${container} || true"
                    sh "docker rm ${container}  || true"
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
