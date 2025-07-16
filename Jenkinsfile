pipeline {
    agent any

    environment {
        CONTAINER_NAME = 'conteneur-nginx'
        IMAGE_NAME = 'image-nginx'
        PORT = '8080'
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    echo "Création image Docker: ${IMAGE_NAME}"
                    sh "docker build -t ${IMAGE_NAME} ."
                }
            }
        }

        stage('Stop & Remove Existing Container') {
            steps {
                script {
                    sh """
                        if [ \$(docker ps -q -f name=${CONTAINER_NAME}) ]; then
                            docker stop ${CONTAINER_NAME}
                        fi
                        if [ \$(docker ps -a -q -f name=${CONTAINER_NAME}) ]; then
                            docker rm ${CONTAINER_NAME}
                        fi
                    """
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    echo "Lancement conteneur ${CONTAINER_NAME} sur le port ${PORT}"
                    sh "docker run -d -p ${PORT}:80 --name ${CONTAINER_NAME} ${IMAGE_NAME}"
                }
            }
        }
    }

    post {
        success {
            echo ":white_check_mark: Site déployé avec succès sur le port ${PORT}"
        }
        failure {
            echo ":x: Le déploiement a échoué."
        }
    }
}
