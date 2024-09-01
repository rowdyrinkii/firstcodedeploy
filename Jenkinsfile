pipeline {
    agent any
    
    environment{
        GIT_URL = 'https://github.com/manishkrishnvimal/firstcodedeploy.git'
        GIT_BRANCH = 'master'
        IMAGE_NAME = 'manish-image'
	    CONTAINER_NAME = 'myapp'
        TARGET_PEM_FILE = credentials('ManAppDeploy')
    }

    stages {
        stage('Cleanup') {
            steps {
                deleteDir()  // Cleans the workspace before the job starts
            }
        }
        
        stage('clean image before run'){
            steps{
                sh 'docker rmi -f ${IMAGE_NAME}'
                sh 'docker system prune -f'
            }
        }
        stage('clone repo') {
            // this stage will clone the repo from github
            steps {
                script {
                
	        //sh 'git clone https://github.com/manishkrishnvimal/firstcodedeploy.git'
                
		sh 'git clone -b ${GIT_BRANCH} ${GIT_URL}'
                sh 'ls -lrth'
                }
            }
        }
        
        
        stage('package'){
            steps{
                script{
            // this step will package and create image
             sh 'pwd'
             dir('firstcodedeploy'){
                 script{
                      sh 'pwd'
                      sh 'ls -lrth'
                      sh 'docker build -t ${IMAGE_NAME} .'
                 }
                }
                }
            }
        }
        
        stage('deploy'){
            steps{
                script{
                    dir('firstcodedeploy'){
                        script{
                              // this stage will deploy the application and container will start
                       sh 'docker rm -f ${CONTAINER_NAME}'
                       sh 'ssh -i ${TARGET_PEM_FILE} ec2-user@13.127.144.125'
		               sh 'docker run -d -p 8090:8080 --name ${CONTAINER_NAME} ${IMAGE_NAME}'
                       sh 'docker ps'
                       sh 'docker logs myapp'
                        }
                    }
                }
            }
        }
        
    }
}

