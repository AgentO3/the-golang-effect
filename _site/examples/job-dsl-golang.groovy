job(type: Matrix) {

  def jobName = "api-ping"
  name jobName

  logRotator(1)

  parameters {
    stringParam("BRANCH", "master")
    stringParam("ENV", "deploy")
    stringParam("BUMP_LEVEL", "patch")
    stringParam("GO_VERSION", "1.3")
  }
  scm {
    git {
      remote {
        url("git@github.com:VividCortex/${jobName}.git")
      }
      branch('origin/$BRANCH')
      wipeOutWorkspace(true)
      relativeTargetDir('go/src/github.com/VividCortex/' + jobName)
      configure { project ->
        project / 'extensions' / 'hudson.plugins.git.extensions.impl.LocalBranch' << {
            localBranch('$BRANCH')
        }
      }
    }
  }

  axes {
        text("DEPLOYENV", "master", "stage", "deploy", "prod")
        combinationFilter("ENV == DEPLOYENV")
  }

  steps {
    shell('export GOROOT=/usr/local/go$GO_VERSION;' +
          'export PATH=$PATH:$GOROOT/bin;' +
          'export GOPATH=${WORKSPACE%/}/go;' +
          'PROJECT=' + jobName +';' +
          'cd $GOPATH/src/github.com/VividCortex/$PROJECT;' +
          'jd build;' +
          'mkdir -p $WORKSPACE/$PROJECT;' +
          'mv $GOPATH/src/github.com/VividCortex/$PROJECT/$PROJECT $WORKSPACE/$PROJECT \n' +
          'cd $WORKSPACE/$PROJECT \n' +
          'chmod +x $PROJECT \n' +
          'V=$(./$PROJECT --version | awk \'{ print $3 }\') \n' +
          'echo VERSION=$V > $WORKSPACE/export.properties')
  }

  publishers {
    archiveArtifacts(jobName + '/' + jobName)

    downstreamParameterized {
      trigger('release-api', "SUCCESS"){
        predefinedProp("DEPLOY_APP", jobName)
        predefinedProp("ENV", '$ENV')
      }

      trigger('api-adaptor-archive', "SUCCESS"){
        predefinedProp("ENV", '$ENV')
        predefinedProp("PROJECT", name)
        predefinedProp("FOLDER", '$WORKSPACE/../configurations/axis-DEPLOYENV/$ENV/builds/$BUILD_ID')
        propertiesFile('$WORKSPACE/DEPLOYENV/$ENV/export.properties')
      }

      trigger('send-message-to-thing', "FAILED"){
        predefinedProp("MESSAGE", 'There was an error building this job. $BUILD_URL/DEPLOYENV=$ENV/console')
      }
    }
  }
}
