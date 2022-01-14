pipeline{
    agent any
    tools { 
      maven 'Maven_Local'
    }
    stages {
        stage('Build Backend') {
           steps {
             bat 'mvn clean package -DskipTests=true'
           }
        }
        stage('Unit Tests') {
          steps {
            bat 'mvn test'
          }
       }
       stage('Sonar Analysis') {
       	  environment {
  	           scannerHome = tool 'SONAR_SCANNER'
  	       }
          steps {
          	  withSonarQubeEnv('SONAR_LOCAL'){
          	   bat "${scannerHome}/bin/sonar-scanner -e -Dsonar.projectKey=DeployBackend -Dsonar.host.url=http://localhost:9000 -Dsonar.login=d4614b9c7d3bfef08e69b8c66c5e32f8a9999fc2 -Dsonar.java.binaries=target -Dsonar.java.binaries=target -Dsonar.coverage.exclusions=**/.mvn/**,**/src/test/**,**/model/**,**Application.java"   
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
              deploy adapters: [tomcat9(credentialsId: 'Teste-1', path: '', url: 'http://localhost:8001/')], contextPath: 'tasks-backend', war: 'target/tasks-backend.war'
          }
       }
       stage('API Test') {
          steps {
              dir('api-test'){
                   git 'https://github.com/LouisMatos/task-api-test.git'
              	   bat 'mvn test' 
              }
          }
       }
       stage('Deploy Frontend') {
          steps {
          		dir('frontend'){
          		    git 'https://github.com/LouisMatos/tasks-frontend.git'
          		    bat 'mvn clean package -DskipTests=true'
              		deploy adapters: [tomcat9(credentialsId: 'Teste-1', path: '', url: 'http://localhost:8001/')], contextPath: 'tasks', war: 'target/tasks.war'
          	}
       	  }
    	}
    	stage('Functional Test') {
          steps {
              dir('functional-test'){
                   git 'https://github.com/LouisMatos/tasks-functional-tests.git'
              	   bat 'mvn test' 
              }
          }
       }
       stage('Deploy Prod') {
          steps {
              bat 'docker-compose down'
              bat 'docker-compose build'
              bat 'docker-compose up -d' 
          }
       }
       stage('Health Check') {
          steps {
          		sleep(15)
              	dir('functional-test'){
              	bat 'mvn verify -Dskip.surefire.tests' 
              }
          }
       }
       post{
           always {
               junit allowEmptyResults: true, testResults: 'target/surefire-reports/*.xml, api-test/target/surefire-reports/*.xml,  functional-test/target/surefire-reports/*.xml, task-funcional-test/target/failsafe-reports/*.xml'
           }
       }

    }
}