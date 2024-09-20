pipeline {
    agent any

    environment{
        IMAGE_NAME = 'manish-image'
	    //CONTAINER_NAME = 'myapp'
    }

    stages {
            stage('Build and Push Docker Image') {
    // have created a iam user with ec2containerfullregisteryaccess and stored access key and secret access key
    // in Jenkins credentials with kind user name and password where username will be access key amd pwd will be 
    // secret access key and the id will be which will be passed as cred id in pipeline below

    // git rebase -i HEAD~n , is used for listing last commits where n means no of commits
    // this prompt editor where pick needs to be replaced with drop which will delete the commits 
    // which has been not pushed to github repo.
    // groups jenkins command to check if jenkins user is part of docker group or not 
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'ecr-demo-credentials', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                        // Login to ECR
                        sh "aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 387620062696.dkr.ecr.ap-south-1.amazonaws.com"

                        // Build Docker image with default latest tag
                        sh "docker build -t test/firstcodedeploy ."

                        // Tag Docker image with tag latest and repo name 
                        sh "docker tag test/firstcodedeploy:latest 387620062696.dkr.ecr.ap-south-1.amazonaws.com/test/firstcodedeploy:latest"

                        // Push latest tag Docker image to ECR
                        sh "docker push 387620062696.dkr.ecr.ap-south-1.amazonaws.com/test/firstcodedeploy:latest"

                        // Tag Docker image with tag Build number and repo name 
                        sh "docker tag test/firstcodedeploy:latest 387620062696.dkr.ecr.ap-south-1.amazonaws.com/test/firstcodedeploy:${BUILD_NUMBER}"

                        // Push Build number tag Docker image to ECR
                        sh "docker push 387620062696.dkr.ecr.ap-south-1.amazonaws.com/test/firstcodedeploy:${BUILD_NUMBER}"
                        
                        // remove all tags images from ec2 jenkins machine docker cache
                        sh "docker image rm test/firstcodedeploy:latest 387620062696.dkr.ecr.ap-south-1.amazonaws.com/test/firstcodedeploy:latest 387620062696.dkr.ecr.ap-south-1.amazonaws.com/test/firstcodedeploy:${BUILD_NUMBER}"

                    }
                }
            }
        } 
        stage('Deploy the application'){
            steps{
                script{
                    // to find where is kubectl binary , command is : 1) whereis kubectl 2) which kubectl 3) type kubectl
                    // sudo mv /home/ubuntu/kubectl /usr/local/bin/  to make kubectl accessible to jenkins user on ec2 machine so that it is able to run kubectl apply commands.
                    echo "Deploying to EKS cluster"
                    sh 'aws eks update-kubeconfig --name cluster --region ap-south-1'
                    sh 'kubectl apply -f ./manifest/deployment.yaml'
                    //sh 'kubectl rollout restart deployment java-app-deployment'
                    sh 'kubectl get pods'
                    //sh 'kubectl wait --for=jsonpath="{.status.phase}"=Running pod'
                    //sh 'kubectl delete pod ${kubectl get pods --for=jsonpath="{.status.phase}"=Running}'
                }
            }
        }          
        }   
}

