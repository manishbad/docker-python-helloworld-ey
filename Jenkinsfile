pipeline {
    agent { label 'docker-node' }

    environment {
        IMAGE_NAME = "python-hello-app"
        CONTAINER_NAME = "hello-container"
        HOST_PORT = "81"
        CONTAINER_PORT = "3000"
        REPO_URL = "https://github.com/manishbad/docker-python-helloworld-ey.git"
        BRANCH = "main"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: "${BRANCH}", url: "${REPO_URL}"
            }
        }

        stage('Stop & Remove Existing Container') {
            steps {
                sh '''
                if [ $(docker ps -aq -f name=$CONTAINER_NAME) ]; then
                    echo "Stopping existing container..."
                    docker stop $CONTAINER_NAME || true
                    docker rm $CONTAINER_NAME || true
                else
                    echo "No existing container found."
                fi
                '''
            }
        }

        stage('Remove Old Image (Optional)') {
            steps {
                sh '''
                if [ $(docker images -q $IMAGE_NAME) ]; then
                    echo "Removing old image..."
                    docker rmi -f $IMAGE_NAME || true
                else
                    echo "No existing image found."
                fi
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                echo "Building Docker image..."
                docker build -t $IMAGE_NAME .
                '''
            }
        }

        stage('Run Docker Container') {
            steps {
                sh '''
                echo "Starting new container..."
                docker run -d \
                    --name $CONTAINER_NAME \
                    -p $HOST_PORT:$CONTAINER_PORT \
                    $IMAGE_NAME
                '''
            }
        }
    }

    post {
        success {
            echo "Application deployed successfully on http://<docker-node-ip>:${HOST_PORT}"
        }
        failure {
            echo "Pipeline failed!"
        }
    }
}
