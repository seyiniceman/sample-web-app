pipeline {
  agent any
  environment {
       imagename = "austinobioma/tomcat"
       registryCredential = 'DockerHub'
       dockerImage = ''
           }
  tools {
    maven 'Maven' 
       }
  stages {
    stage ('Build') {
      steps {
        sh 'mvn clean package'
      }
    }
    stage('Building Docker image') {
          steps{
                script {
                     dockerImage = docker.build imagename
                          }
                      }
                }
     stage('Deploy Image') {
           steps{
               script {
                    docker.withRegistry( '', registryCredential ) {
                    dockerImage.push("$BUILD_NUMBER")
                    dockerImage.push('latest')
                                              }
                                    }
                             }
                  }
     stage('Remove Unused docker image') {
          steps{
              sh "docker rmi $imagename:$BUILD_NUMBER"
              sh "docker rmi $imagename:latest"
                        }
            }
    stage ('Deploy To Tomcat Server') {
      steps{
        script {
         deploy adapters: [tomcat9(credentialsId: 'Deployer', path: '', url: 'http://18.209.228.246:8080')], contextPath: '/hello-world', onFailure: false, war: '**/hello-world.war'
      }
     }
   }
 }
}

