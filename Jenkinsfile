pipeline{
    agent any
    stages {
        stage('Build Backend') {
           
               withMaven(maven: 'mvn') {
               	  sh 'mvn clean package -DskipTest=true'
               }
           
        }
    }
}
