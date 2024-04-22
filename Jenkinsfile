pipeline {
    agent any
    stages {
        stage('Creating Infrastructure') {
            steps {
                script {
                   sh'terraform init'
                   sh 'terraform apply  --auto-approve'
                }
            }
        }
        stage('Installing Nginx with Ansible') {
            steps {
                script {
                   sh'ansible-playbook -i inventory -u ubuntu --private-key=/var/jenkins_home/haitham.pem InstallNginx.yaml'
                }
            }
        }
    }
}
