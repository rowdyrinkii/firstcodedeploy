pipeline {
    agent any
    
    environment{
        //GIT_URL = 'https://github.com/manishkrishnvimal/firstcodedeploy.git'
        //GIT_BRANCH = 'master'
        //IMAGE_NAME = 'manish-image'
	    //CONTAINER_NAME = 'myapp'
        //TARGET_PEM_FILE = credentials('ManAppDeploy')
        //TARGET_EC2_USER = 'ec2-user'
        //TARGET_EC2_HOST = '13.127.175.136'
       // DEPLOY_SCRIPT = 'deploy.sh' // Deployment script
       BUILD_TAG = "${BUILD_NUMBER}"
    }


    stages {
                stage('Build and Push Docker Image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'ecr-demo-credentials', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                        // Login to ECR
                        sh "aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 387620062696.dkr.ecr.ap-south-1.amazonaws.com"
                        sh "docker build -t test/firstcodedeploy:${BUILD_TAG} ."

                        // Tag Docker image
                        sh "docker tag test/firstcodedeploy:${BUILD_TAG} 387620062696.dkr.ecr.ap-south-1.amazonaws.com/test/firstcodedeploy:${BUILD_TAG}"

                        // Push Docker image to ECR
                        sh "docker push 387620062696.dkr.ecr.ap-south-1.amazonaws.com/test/firstcodedeploy:${BUILD_TAG}"
                    }
                }
            }
       }
        /*
        stage('clean image before run'){
            steps{
                deleteDir()  // Cleans the workspace before the job starts
                sh 'docker rmi -f ${IMAGE_NAME}'
                sh 'docker system prune -f'
            }
        }
        stage('clone repo') {
            steps {
                script {
                      sh 'git clone -b ${GIT_BRANCH} ${GIT_URL}'
                      sh 'ls -lrth'
                }
            }
        }
        */

        /*
        stage('package'){
            steps{
                script{
            // this step will package and create image
             sh 'pwd'
             dir('firstcodedeploy'){
                 script{
                      sh 'pwd'
                      sh 'ls -lrth'
                      sh 'aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 387620062696.dkr.ecr.ap-south-1.amazonaws.com'
                      //sh 'docker build -t ${IMAGE_NAME} .'
                      sh 'docker build -t test/firstcodedeploy .'
                      sh 'docker tag test/firstcodedeploy:latest 387620062696.dkr.ecr.ap-south-1.amazonaws.com/test/firstcodedeploy:latest'
                      sh 'docker push 387620062696.dkr.ecr.ap-south-1.amazonaws.com/test/firstcodedeploy:latest'
                 }
                }
                }
            }
        } */


            /*    stage('SSH to Remote Server') {
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
        } */
        /*
        stage('deploy'){
            steps{
                script{
                    dir('firstcodedeploy'){
                        script{
                             // this stage will deploy the application and container will start
                           sh 'docker rm -f ${CONTAINER_NAME}'
                           //sh 'ssh -i ${TARGET_PEM_FILE} ec2-user@13.127.144.125'
		                   //sh 'docker run -d -p 8090:8080 --name ${CONTAINER_NAME} ${IMAGE_NAME}'
                           sh 'docker run -d -p 8090:8080 --name ${CONTAINER_NAME} firstcodedeploy'
                           sh 'docker ps'
                           sh 'docker logs myapp' 
                       
                    }
                             
                        }
                    }
                }
            }
            */
            
        }
        
    
}

