pipeline {
    agent any
    tools {
        maven 'MAVEN_LOCAL'
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
                withSonarQubeEnv('SONAR_LOCAL') {
                    sh "${scannerHome}/bin/sonar-scanner -e -Dsonar.projectKey=BackDeploy -Dsonar.host.url=http://localhost:9000 -Dsonar.login=sqa_a63a4098fcc7116376ceeceb0be4c3064f319d59 -Dsonar.java.binaries=target -Dsonar.coverage.exclusions=**/.mvn/**,**/src/test/**,**/model/**,**Application.java"
                }
            }
        }
    }
}
