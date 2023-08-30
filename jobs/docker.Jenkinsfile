#!/usr/bin/env groovy

pipeline {
    agent none
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
