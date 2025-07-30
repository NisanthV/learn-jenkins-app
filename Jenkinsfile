pipeline {
    agent any

    stages {
        stage('Build') {
            
            agent{
                docker {
                    image 'node:18-alpine'
                    reuseNode true
                }
            }
            
            steps {
                
                sh'''
                    npm ci
                    npm run build
                
                '''
            }
        }

        stage('Test'){

            agent {
                docker {

                    image 'node:18-alpine'
                    reuseNode true
                }
            }

            steps{
                    sh '''
                        test -f build/index.html
                        npm test
                    '''
            }
        }

        stage('Python'){

            agent{

                docker{

                    image 'python:3.12.11-bookworm'
                    reuseNode true
                }
            }

            steps{
                sh'''
                    python3 hai.py
                '''
            }

        }

        stage('Docker'){

            agen{
                docker{
                    image 'node:18-alpine'
                    reuseNode true
                }
            }


            steps{

                withCredentials([UsernamePassword(credentialsId: "docker_auth", passwordVariable: "docker_pass, usenameVariable: "docker_user")]){

                    sh'''
                        docker login -u ${env.docker_user} -p ${env.docker_pass}

                        sh docker build -t ${env.docker_user}/learn-jenkin .

                        sh docker push ${env.docker_user}/learn-jenkin:latest
                    '''

                } 

            }
        }
    }

    post {
        always{
            junit 'test-results/junit.xml'
        }
    }
}