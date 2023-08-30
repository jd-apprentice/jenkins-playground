#!/usr/bin/env groovy

pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            agent {
                docker {
                    image 'docker:latest'
                }
            }
            steps {
                sh 'docker build -t my-node-app:latest .'
            }
        }

        stage('Deploy') {
            agent any
            steps {
                sh 'docker run my-node-app:latest node --version'
            }
        }
    }
}
