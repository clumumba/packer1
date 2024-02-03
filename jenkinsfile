pipeline {
  agent {
    any {
      image 'hashicorp/packer:latest'
      args '--user root -v /var/run/docker.sock:/var/run/docker.sock' // mount Docker socket to access the host's Docker daemon
    }
  }
  stages {
    stage("Building AMI") {
      steps {
        sh "packer init aws-ami.pkr.hcl"
        sh "packer build aws-ami.pkr.hcl"
      }
    }
  } 
}
