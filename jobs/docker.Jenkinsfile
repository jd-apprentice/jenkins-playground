#!/usr/bin/env groovy

// node:18.17.1-alpine3.18
// ruby:3.2.2-alpine3.18
// python:3.11.5-alpine3.18
// php:8.2.9-alpine3.18
// golang:1.21.0-alpine3.18

pipeline {
    agent none
    stages {
        stage('node') {
            agent { docker { image 'node:18.17.1-alpine3.18' } }
            steps {
                sh 'node --version'
            }
        }
        stage('python') {
            agent { docker { image 'python:3.11.5-alpine3.18' } }
            steps {
                sh 'python --version'
            }
        }
    }
}
