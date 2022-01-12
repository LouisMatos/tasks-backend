pipeline{
    agent any
    tools { 
      maven 'MAVEN_Local'
    }
    stages {
        stage('Build Backend') {
           steps {
               withMaven(maven: 'mvn') {
               	  sh 'mvn clean package -DskipTest=true'
               }
           }
        }
    }
}
