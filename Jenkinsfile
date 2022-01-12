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
    }
}
