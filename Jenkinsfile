pipeline{
    agent any
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
