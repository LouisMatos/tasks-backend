pipeline{
    agent any
    stages {
        stage('Build Backend') {
           steps {
               sh 'maven clean package -DskipTest=true'
           }
        }
    }
}
