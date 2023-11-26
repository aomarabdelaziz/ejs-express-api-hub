def buildNumber = currentBuild.number
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
        stage('Building and Pushing Image') {
            steps {
                container('docker') {
                    script {
                        app = docker.build("abdelazizomar/ejs-api-hub"+":"+buildNumber)
                        // docker.withRegistry('jfrog-cred'){
                        //     app.push()
                        // }    
                    }
                }
            }
        }       
    }
}
