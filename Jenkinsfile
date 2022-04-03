def getImageTag(branch) {
    if (branch.equals('master')){
        return sh(returnStdout: true, script: 'echo -n "$(git rev-parse --short=8 @^2)"')
    } else {
        return sh(returnStdout: true, script: 'echo -n "$(git rev-parse --short=8 @)"')
    }
}

pipeline {
    agent any
    environment {
        imageTag      = getImageTag(env.branch)
        repositoryUrl = 'registry.local'
    }
    stages{
        stage('SCM Pull'){
            steps{
                git credentialsId: 'git-creds', url: 'https://github.com/ahmetchakmak/b-safe.git'
            }
        }
        stage('Docker Build') {
            steps{
                sh 'docker build --tag bsafe:${imageTag} .'
            }    
        }
        stage('Docker Push') {
            steps{
                script{    
                    docker.withRegistry('http://registry.local:5000')
                        app.push("bsafe:${imageTag}")
                }
            }
        }
    }
}