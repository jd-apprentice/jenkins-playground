// Build jenkins job with docker agent

pipeline {
    agent None
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build') {
            steps {
                docker.build('node:18-alpine')
            }
        }
        stage('Deploy') {
            steps {
                script {
                    docker.image('node:18-alpine').run('node --version')
                }
            }
        }
    }
}
