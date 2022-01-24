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
                copyArtifacts filter: 'terraform.tfstate', fingerprintArtifacts: true, projectName: '${JOB_NAME}', selector: specific('${BUILD_NUMBER}')
                cd infra/prod
            else
                copyArtifacts filter: 'terraform.tfstate', fingerprintArtifacts: true, projectName: '${JOB_NAME}', selector: specific('${BUILD_NUMBER}')
                cd infra/dev
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
            archiveArtifacts artifacts: 'terraform.tfstate', fingerprint: true
        }
    }
  }
}
