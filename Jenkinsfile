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

            agent{
                docker{
                    image 'node:18-alpine'
                    reuseNode true
                }
            }


            steps{

                withCredentials([usernamePassword(credentialsId: "docker_auth", passwordVariable: "docker_pass", usernameVariable: "docker_user")]){

                    sh'''
                        docker login -u $docker_user -p $docker_pass

                        docker build -t $docker_user/learn-jenkin .

                        docker push $docker_user/learn-jenkin:latest
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