#!/usr/bin/env groovy

pipeline {
    agent none
    stages {
        stage('checkout') {
            agent any
            steps {
                git(
                    branch: 'main',
                    url: 'https://github.com/jd-apprentice/jenkins-playground',
                )
            }
        }
        stage('build') {
            agent {
                dockerfile {
                    filename 'docker/Node.Dockerfile'
                }
            }
            steps {
                sh 'node --version'
            }
        }
    }
}
