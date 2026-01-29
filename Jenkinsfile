pipeline {
  agent any

  environment {
    AWS_REGION = "ap-south-1"
    ECR_REPO = "551647579930.dkr.ecr.ap-south-1.amazonaws.com/devops-java-app"
  }

  stages {

    stage('Checkout') {
      steps {
        git 'https://github.com/your-repo/devops-java-app.git'
      }
    }

    stage('Build Java App') {
      steps {
        sh 'mvn clean package -DskipTests'
      }
    }

    stage('Build Docker Image') {
      steps {
        sh 'docker build -t devops-java-app:1.0 .'
      }
    }

    stage('Push to ECR') {
      steps {
        sh '''
          aws ecr get-login-password --region $AWS_REGION |
          docker login --username AWS --password-stdin $ECR_REPO
          docker tag devops-java-app:1.0 $ECR_REPO:1.0
          docker push $ECR_REPO:1.0
        '''
      }
    }

    stage('Deploy to Kubernetes') {
      steps {
        sh 'kubectl apply -f k8s/'
      }
    }
  }
}




