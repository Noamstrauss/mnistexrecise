def env="dev"
pipeline {
  agent any

// Don't forget to make use in the relevant places:
// copyArtifacts filter: '...your..terraform..state..path...', projectName: '${JOB_NAME}'
// archiveArtifacts artifacts: '...your..terraform..state..path...', onlyIfSuccessful: true

  stages {
    stage('Terraform Init & Plan'){
        when { anyOf {branch "master";branch "dev";changeRequest()} }
        steps {
            sh '''
            if [ "$BRANCH_NAME" = "master" ] || [ "$CHANGE_TARGET" = "master" ]; then
                env="infra/prod"
                echo 'you env is ${env}'
                cd $env
            else
                echo 'you env is ${env}'
                cd $env

            fi
            terraform init
            terraform plan

            '''
        }
    }

    stage('Terraform Apply'){
        when { anyOf {branch "master";branch "dev"} }
        input {
            message "Do you want to proceed for infrastructure provisioning?"
        }
        steps {
            sh '''
            if [ "$BRANCH_NAME" = "master" ] || [ "$CHANGE_TARGET" = "master" ]; then
                env="infra/prod"
                cd $env
            else
                env="infra/dev"
                cd $env
            fi
            terraform apply -auto-approve

            '''
            archiveArtifacts artifacts: '$env/terraform.tfstate', onlyIfSuccessful: true
        }
    }
  }
}
