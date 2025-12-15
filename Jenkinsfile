pipeline {
    environment {
        DOCKERHUB_CREDENTIALS = credentials("ceae9afd-2354-48cc-aeaa-56c88ca7cfc5")
    }
    agent {
        label "K-M"
    }
    stages {
        stage('Git') {
            steps {
                git branch: 'main', url: 'https://github.com/ashishgen/Clock.git'
            }
        }
        stage('Docker') {
            steps {
                script {
                    // Build the Docker image
                    sh 'sudo docker build -t ashishpandey1991/clock:latest .'

                    // Login to Docker Hub using credentials
                    withCredentials([usernamePassword(credentialsId: 'ceae9afd-2354-48cc-aeaa-56c88ca7cfc5', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh 'sudo docker login -u $DOCKER_USER -p $DOCKER_PASS'
                    }

                    // Push the Docker image to Docker Hub
                    sh 'sudo docker push ashishpandey1991/clock'
                }
            }
        }
        stage('K-M') {
            steps {
                // Apply Kubernetes Deployment and Service
                sh 'kubectl config current-context'
                sh 'kubectl get nodes'
                sh "kubectl apply -f deploy.yaml"
                sh "kubectl apply -f service.yaml"
            }
        }
    }
}
