pipeline {
    agent {
        kubernetes {
            yaml '''
                apiVersion: v1
                kind: Pod
                spec:
                  volumes:
                  - name: docker-socket
                    emptyDir: {}
                  containers:
                  - name: maven
                    image: maven:alpine
                    command:
                    - cat
                    tty: true
                  - name: docker
                    image: docker:19.03.1
                    readinessProbe:
                      exec:
                        command: [sh, -c, "ls -S /var/run/docker.sock"]
                    command:
                    - sleep
                    args:
                    - 99d
                    volumeMounts:
                    - name: docker-socket
                      mountPath: /var/run
                  - name: docker-daemon
                    image: docker:19.03.1-dind
                    securityContext:
                      privileged: true
                    volumeMounts:
                    - name: docker-socket
                      mountPath: /var/run
            '''
        }
    }
    stages {
        stage('Clone') {
            steps {
                container('maven') {
                    
                     git branch: 'main', changelog: false, poll: false, url: 'https://mohdsabir-cloudside@bitbucket.org/mohdsabir-cloudside/java-app.git'                    }
                
            }
        }
        stage('Build-Jar-file-Maven') {
            steps {
                container('maven') {
                    sh 'mvn package'
                }
            }
        }        
        stage('Build-Jar-file-Docker') {
            steps {
                container('docker') {
                    script {
                        app = docker.build("heysss")
                    }
                }
            }
        }       
    }
}
