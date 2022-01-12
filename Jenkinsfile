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
          	   sh "${scannerHome}/bin/sonar-scanner -e -Dsonar.projectKey=DeployBackend -Dsonar.host.url=http://172.18.1.1:9000 -Dsonar.login=a82acaa41c272496a6011efad6f4c2b7f59fb18f -Dsonar.java.binaries=target -Dsonar.java.binaries=target -Dsonar.coverage.exclusions=**/.mvn/**,**/src/test/**,**/model/**,**Application.java"   
          	  }
          }
       }
       stage("Quality Gate"){
         steps {
             timeout(time: 1, unit: 'MINUTE') {
              def qg = waitForQualityGate()
              if (qg.status != 'OK') {
                  error "Pipeline aborted due to quality gate failure: ${qg.status}"
              }
          }
         }
          
      }
    }
}

