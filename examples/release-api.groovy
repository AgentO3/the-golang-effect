job {
  name "release-api"

  logRotator(1)

  parameters {
    stringParam("DEPLOY_APP", "all")
    stringParam("ENV", "deploy")
  }

  scm {
    git {
      remote {
        url("git@github.com:VividCortex/ansible-playbook.git")
      }
      branch('origin/master')
      wipeOutWorkspace(true)
      configure { project ->
        project / 'extensions' / 'hudson.plugins.git.extensions.impl.LocalBranch' << {
            localBranch('master')
        }
      }
    }
  }

  steps {
    shell('export HOME=/root;' +
          'eval "$(ssh-agent)";' +
          'ssh-add;' +
          'ansible-playbook -i $ENV infra/deploy-api.yml -e "deploy_app=$DEPLOY_APP" -u ansible -vv')
  }

  publishers {
    downstreamParameterized {
      trigger('send-message-to-thing', "SUCCESS"){
        predefinedProp("MESSAGE", 'Successfully deployed $DEPLOY_APP API to $ENV. (successful)')
      }

      trigger('task-deploy-event', "SUCCESS"){
        predefinedProp("ENV", '$ENV')
        predefinedProp("APP", '$DEPLOY_APP')
      }

      trigger('send-message-to-thing', "FAILED"){
        predefinedProp("MESSAGE", 'Unable to complete job. $BUILD_URL (failed)')
      }
    }
  }
}
