pipeline {
    agent any

    environment {
        KUBECONFIG = '/home/vagrant/.kube/config'
    }

    stages {
        stage('List Pods') {
            steps {
                script {
                 
                    sh 'kubectl version --client'
                    sh 'kubectl get pods --all-namespaces'
                    
                }
            }
        }
    }

  
}