pipeline {
    agent { label 'DEPI' }

    environment {
        // Define environment variables
        DOCKER_IMAGE_NAME = 'obad20xx/depi'
        DOCKER_IMAGE_TAG = 'depia'
        GITHUB_REPO = 'https://github.com/yourusername/your-repo.git' // Replace with your repo
        TERRAFORM_DIR = 'terraform'
        ANSIBLE_DIR = 'Ansible'
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials') // ID of Docker Hub credentials in Jenkins
        ANSIBLE_HOST_KEY_CHECKING = 'False' // Disable host key checking
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                dir("${env.TERRAFORM_DIR}") {
    
                        sh 'terraform init'
                    
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir("${env.TERRAFORM_DIR}") {
                    
                        sh 'terraform apply -auto-approve -var-file=terraform.dev.tfvars'
                    
                }
            }
        }

        stage('Retrieve EC2 IP') {
            steps {
                script {
                    // Extract the public IP from Terraform output
                    dir("${env.TERRAFORM_DIR}") {
                        ec2_ip = sh(script: 'terraform output -raw app_instance_public_ip', returnStdout: true).trim()
                    }
                    // Update Ansible hosts.ini
                    writeFile file: "${env.ANSIBLE_DIR}/hosts.ini", text: """
                    [webserver]
                    ${ec2_ip} ansible_user=ubuntu ansible_ssh_private_key_file=../node1.pem ansible_python_interpreter=/usr/bin/python3
                    """
                    // Make the SSH key available to Ansible
                    sh "chmod 600 ${env.ANSIBLE_DIR}/../node1.pem"

                    // Store the EC2 IP in the global environment variable
                    env.EC2_IP = ec2_ip
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${env.DOCKER_IMAGE_NAME}:${env.DOCKER_IMAGE_TAG}")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('', 'dockerhub-credentials') {
                        dockerImage.push()
                    }
                }
            }
        }

        stage('Run Ansible Playbook') {
            steps {
                dir("${env.ANSIBLE_DIR}") {
                        sh """
                            ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts.ini playbook.yml
                        """
                    
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
        success {
            echo 'Deployment completed successfully!'
            echo "EC2 Instance IP: ${env.EC2_IP}"
            // Optional: Add notifications here (e.g., Email, Slack)
        }
        failure {
            echo 'Deployment failed. Check the logs for details.'
        }
    }
}
