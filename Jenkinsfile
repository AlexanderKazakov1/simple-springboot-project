pipeline {
    agent {
        docker {
            image 'a1kazakov/build-container:latest'
            args '--privileged -v /var/run/docker.sock:/var/run/docker.sock -v /root:/root -u root'
        }
    }

    stages {
        stage('Clone project') {
            steps {
                git(url: 'https://github.com/AlexanderKazakov1/simple-springboot-project.git', branch: 'feature/jenkinsfile', poll: true, credentialsId: 'git')
            }
        }

        stage('Build jar') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Make docker image') {
            steps {
                sh 'docker build -t simple-springboot-project -f Dockerfile .'
                sh 'docker tag simple-springboot-project:latest a1kazakov/simple-springboot-project:latest'
                withDockerRegistry(credentialsId: 'bd72d214-494a-45d6-8c0e-6ba5be29bb06', url: 'https://index.docker.io/v1/') {
                   sh 'docker push a1kazakov/simple-springboot-project:latest'
                }
            }
        }

        stage('Run docker on second vm') {
            steps {
                sshagent(['299a1801-9bbd-436f-bb7e-1041c5e7c216']) {
                    sh 'ssh user@158.160.58.73'
                    withDockerRegistry(credentialsId: 'bd72d214-494a-45d6-8c0e-6ba5be29bb06', url: 'https://index.docker.io/v1/') {
                       sh 'docker pull a1kazakov/simple-springboot-project:latest'
                    }
                    sh 'docker run a1kazakov/simple-springboot-project:latest'
                }
            }
        }
    }
}