#!/usr/bin/env groovy

pipeline {
    agent {
        dockerfile {
            filename 'Node.Dockerfile'
            dir '../docker'
        }
    }
    stages {
        stage('node') {
            steps {
                sh 'node --version'
            }
        }
    }
}
