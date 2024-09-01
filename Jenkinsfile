pipeline {
    agent any
    
    environment{
        GIT_URL = 'https://github.com/manishkrishnvimal/firstcodedeploy.git'
        GIT_BRANCH = 'master'
        IMAGE_NAME = 'manish-image'
	    CONTAINER_NAME = 'myapp'
        //TARGET_PEM_FILE = credentials('ManAppDeploy')
        TARGET_EC2_USER = 'ec2-user'
        TARGET_EC2_HOST = '13.127.144.125'
       // DEPLOY_SCRIPT = 'deploy.sh' // Deployment script
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

                stage('SSH to Remote Server') {
            steps {
                script {
                    // Use withCredentials to access the SSH private key stored in Jenkins
                    withCredentials([sshUserPrivateKey(credentialsId: 'ManAppDeploy', 
                                                      keyFileVariable: 'SSH_KEY', 
                                                      usernameVariable: 'SSH_USER')]) {
                        // Run your SSH command
                        sh '''
                        ssh -i $SSH_KEY -o StrictHostKeyChecking=no ec2-user@$TARGET_EC2_HOST "echo 'Hello from the remote server!'"
                        '''
                    }
                }
            }
        }
        
        stage('deploy'){
            steps{
                script{
                    dir('firstcodedeploy'){
                        script{/*
                             withCredentials([file(credentialsId: 'ManAppDeploy', variable: 'SSH_KEY')]) {
                        sh """
                            # Transfer the artifact to the target EC2 instance
                            scp -i $SSH_KEY -o StrictHostKeyChecking=no target/myapp.jar ${TARGET_EC2_USER}@${TARGET_EC2_HOST}:/tmp/
                            
                            # Execute the deployment script on the target EC2 instance
                            ssh -i $SSH_KEY -o StrictHostKeyChecking=no ${TARGET_EC2_USER}@${TARGET_EC2_HOST} 'bash -s' < 
*/
                             # this stage will deploy the application and container will start
                          docker rm -f ${CONTAINER_NAME}
                       ssh -i ${TARGET_PEM_FILE} ec2-user@13.127.144.125
		               docker run -d -p 8090:8080 --name ${CONTAINER_NAME} ${IMAGE_NAME}
                       docker ps
                       docker logs myapp
                        """
                    }
                      /* this stage will deploy the application and container will start
                       sh 'docker rm -f ${CONTAINER_NAME}'
                       sh 'ssh -i ${TARGET_PEM_FILE} ec2-user@13.127.144.125'
		               sh 'docker run -d -p 8090:8080 --name ${CONTAINER_NAME} ${IMAGE_NAME}'
                       sh 'docker ps'
                       sh 'docker logs myapp' */       
                        }
                    }
                }
            }
        }
        
    }
}

