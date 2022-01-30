def env= "dev"
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
                $env="infra/prod"
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
                INFRA_ENV=infra/prod
                cd $INFRA_ENV
            else
                INFRA_ENV=infra/dev
                cd $INFRA_ENV
            fi
            terraform apply -auto-approve

            '''
            archiveArtifacts artifacts: '$INFRA_ENV/terraform.tfstate', onlyIfSuccessful: true
        }
    }
  }
}
