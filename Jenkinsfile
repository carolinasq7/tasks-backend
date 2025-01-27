pipeline {
    agent any
    stages {
    tools {
        maven 'MAVEN_LOCAL'
    }
        stage ('Build Backend') {
            steps {
                sh 'mvn clean package -DskipTests=true'
            }
        }
       stage ('Unit Tests') {
           steps {
               sh 'mvn test'
           }
       }
    }
}