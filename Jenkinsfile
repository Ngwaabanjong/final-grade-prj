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
        stage ('deploy to tomcat') {
            steps {
                sshagent(['user-key']) {
                    sh "scp -o StrictHostKeyChecking=no webapp/target/ABCtechnologies-1.0.war ec2-user@34.234.164.39:/opt/tomcat/webapps" 
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






