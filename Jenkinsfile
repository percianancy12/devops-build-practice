pipeline {
  agent any
  environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')
  }
  stages {
    stage('Build Docker Image') {
      steps {
        sh './build.sh'
      }
    }
    stage('Push to DockerHub') {
      steps {
        script {
          if (env.BRANCH_NAME == 'dev') {
            sh """
              docker login -u ${DOCKERHUB_CREDENTIALS_USR} -p ${DOCKERHUB_CREDENTIALS_PSW}
              docker tag my-react-app:latest percianancy/dev:latest
              docker push percianancy/dev:latest
            """
          } else if (env.BRANCH_NAME == 'main') {
            sh """
              docker login -u ${DOCKERHUB_CREDENTIALS_USR} -p ${DOCKERHUB_CREDENTIALS_PSW}
              docker tag my-react-app:latest percianancy/prod:latest
              docker push percianancy/prod:latest
            """
          }
        }
      }
    }
    stage('Deploy') {
      steps {
        script {
          if (env.BRANCH_NAME == 'dev') {
            sh './deploy.sh dev'
            // or: sh 'docker-compose -f docker-compose.dev.yml up -d --build'
          } else if (env.BRANCH_NAME == 'main') {
            sh './deploy.sh prod'
            // or: sh 'docker-compose -f docker-compose.prod.yml up -d --build'
          }
        }
      }
    }
  }
}