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
        stage('Quality Gate') {
            steps {
                sleep(5)
                timeout(time: 1, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }
        stage('Deploy Backend') {
            steps {
                deploy adapters: [tomcat9(credentialsId: 'TomcatLogin', path: '', url: 'http://localhost:8001/')], contextPath: 'tasks-backend', war: 'target/tasks-backend.war'
            }
        }
        stage('API Test') {
            steps {
                dir('api-test') {
                    git 'https://github.com/carolinasq7/tasks-api-test.git'
                    sh 'mvn test'
                }
            }
        }
        stage('Deploy Frontend') {
            steps {
                dir('tasks-frontend') {
                    git 'https://github.com/carolinasq7/tasks-frontend.git'
                    sh 'mvn clean package'
                    deploy adapters: [tomcat9(credentialsId: 'TomcatLogin', path: '', url: 'http://localhost:8001/')], contextPath: 'tasks', war: 'target/tasks.war'
                }
            }
        }
        stage('Functional Tests') {
            steps {
                dir('functional-tests') {
                    git 'https://github.com/carolinasq7/tasks-functional-test.git'
                    sh 'mvn test'
                }
            }
        }
    }
}




