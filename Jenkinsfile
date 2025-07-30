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
                    npi ci
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

        
    }

    post {
        always{
            junit 'test-results/junit.xml'
        }
    }
}
