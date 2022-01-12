pipeline{
    agent any
    tools { 
      maven 'Maven_Local'
    }
    stages {
        stage('Build Backend') {
           steps {
             sh 'mvn clean package -DskipTests=true'
           }
        }
        stage('Unit Tests') {
          steps {
            sh 'mvn test'
          }
       }
       stage('Sonar Analysis') {
       	  environment {
  	           scannerHome = tool 'SONAR_SCANNER'
  	       }
          steps {
          	  withSonarQubeEnv('SONAR_LOCAL'){
          	   sh "${scannerHome}/bin/sonar-scanner -e -Dsonar.projectKey=DeployBackend -Dsonar.host.url=http://172.26.240.1:9000 -Dsonar.login=a82acaa41c272496a6011efad6f4c2b7f59fb18f -Dsonar.java.binaries=target -Dsonar.java.binaries=target -Dsonar.coverage.exclusions=**/.mvn/**,**/src/test/**,**/model/**,**Application.java"   
          	  }
          }
       }
       stage('Quality Gate') {
          steps {
              sleep(5)
              timeout(time: 1, unit: 'HOURS'){
                  waitForQualityGate abortPipeline: true                    
              }
          }
       }
       stage('Deploy Backend') {
          steps {
              deploy adapters: [tomcat9(credentialsId: 'Teste-1', path: '', url: 'http://172.26.240.1:8001/')], contextPath: 'tasks-backend', war: 'target/tasks-backend.war'
          }
       }
       stage('API Test') {
          steps {
              git 'https://github.com/LouisMatos/task-api-test.git'
              sh 'mvn test'
          }
       }
    }
}



