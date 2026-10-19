
pipeline {
    agent any

    options {
        timestamps()
        disableConcurrentBuilds()
    }

    environment {
        TF_IN_AUTOMATION = 'true'
        TF_INPUT = 'false'
        AWS_DEFAULT_REGION = 'ap-south-1'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Check Tools') {
            steps {
                sh '''
                    terraform -version
                    aws --version
                    git --version
                '''
            }
        }

        stage('Terraform Format') {
            steps {
                sh 'terraform fmt -recursive'
                sh 'terraform fmt -check -recursive'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init -input=false'
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh '''
                    terraform plan \
                      -input=false \
                      -no-color \
                      -out=tfplan
                '''
            }
        }

        stage('Approval') {
            steps {
                input message: 'Review the Terraform plan output and approve the infrastructure changes only if they are correct.',
                      ok: 'Approve'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -input=false -no-color tfplan'
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully.'
        }

        failure {
            echo 'Pipeline failed. Check the console output.'
        }

        always {
            sh 'rm -f tfplan || true'
        }
    }
}
