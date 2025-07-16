pipeline {
    agent any
    envirnoment {
        port = "8080"
        container = "docker-with-jenkins"
        image = "basic-site"
    }
    stages { 
        stage("build") {
            steps {
                docker run -p "${port}:80" "${container}
                docker build . -t ${image}
            }
        }
        stage("run") {
            steps {
                docker run -p "${port}:80" "${image}
            }
        }
        stage("stop") {
            steps {
                script {
                    def result = sh(
                        script: "docker ps -a --filter 'name="${container}"' --format '{{.Names}}'",
                        returnStdout: true
                    ).trim()

                    if (result == "${container}") {
                        docker stop "${container}"
                        docker rm "${container}"
                    }
                }
            }
        }
        stage("deploy") {
            steps {
                docker run -d -p "${port}":80 --name "${container}" "${image}"
            }
        }
    }
    post {
        success {
            echo "Site deployé sur le port "${port}""
        }
        failure {
            echo "Site non déployé"
        }
    }
}
