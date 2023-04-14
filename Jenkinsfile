pipeline {
    agent any
    tools{
        maven 'maven'
    }
    stages{
        stage('Build Maven'){
            steps{
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Ngwaabanjong/final-abc-prj.git']])
                sh 'mvn clean install'
            }
        }
        stage('Build docker image'){
            steps{
                script{
                    sh 'docker build -t Ngwaabanjong/abc-prj .'
                }
            }
        }
        stage('Push image to Hub'){
            steps{
                script{
                    withCredentials([string(credentialsId: 'hub-key', variable: 'hub-pwd')]) {
                    sh 'docker login -u Ngwaabanjong -p ${hub-pwd}'

}
                    sh 'docker push Ngwaabanjong/abc-prj'
                }
            }
        }
        stage ('Push to Tomcat') {
            steps {
                script {
                    deploy adapters: [tomcat9(credentialsId: 'tomcat-key', variable: 'tomcat-key', url: 'http://http://3.237.61.61:8080')], contextPath: '/pipeline', onFailure: false, war: 'webapp/target/*.war' 
                }
            }
        }
        

        stage('Deploy to k8s with Ansible'){
            steps{
                script{
                    sh "ansible-playbook ansible.yaml"
                }
            }
        }
    }
}






