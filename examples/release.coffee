# Description:
#   Triggers the deployment of a job
#
# Commands:
#   hubot stage - Deploy various services to staging server. See /help stage for details.
#   hubot release - Releases various services to production. See /help release for details.
#   hubot install - Installs agents to production. See /help install for details.
# Notes:
# http://rubular.com/r/jyOaZwkjfZ


module.exports = (robot) ->
  robot.respond /stage (.+)/i, (msg) ->
    commandArray = msg.match[1].replace(/^\s+|\s+$/g, "").split(/\s+/)
    repo = commandArray[0]
    if repo == "ng-app"
        branch = commandArray[1] || "master"
        destination = commandArray[2] || "timestamp"
        env = "stage"
        message = """Deploying #{repo} branch #{branch} to Pooroku."""
        job = repo
        params = "BRANCH=#{branch}&ENV=#{env}&DESTINATION=#{destination}"

    else if repo == "sf-app"
        branch = commandArray[1] || "master"
        env = "stage"
        message = """Deploying #{repo} branch of #{branch}."""
        job = repo
        params = "BRANCH=#{branch}&ENV=#{env}"

    else if repo == "landing-page"
        branch = "master"
        env = "stage"
        message = """Deploying #{repo} to #{env}."""
        job = repo
        params = "BRANCH=#{branch}&ENV=#{env}"
    else if repo == "support-docs"
        branch = "master"
        env = "stage"
        message = """Deploying #{repo} to #{env}."""
        job = repo
        params = "BRANCH=#{branch}&ENV=#{env}&DESTINATION=support"
    else if repo == "agents"
        branch = commandArray[1] || "origin/master"
        user = msg.message.user.name
        message = """Deploying #{repo} #{branch} to staging."""
        job = repo + "-stage"
        params = "BRANCH=#{branch}&USER=#{user}"
    else if repo.match /api-(.+)/i
        branch = commandArray[1] || "master"
        user = msg.message.user.name
        message = """Deploying #{repo} #{branch} to staging."""
        job = repo
        params = "BRANCH=#{branch}&USER=#{user}&ENV=stage"
    else if repo.match /services/i
        branch = commandArray[1] || "master"
        user = msg.message.user.name
        message = """Deploying #{repo} #{branch} to staging."""
        job = repo
        params = "BRANCH=#{branch}&USER=#{user}&ENV=stage"
    else
        branch = commandArray[1] || "master"
        user = msg.message.user.name
        message = """Deploying #{repo} #{branch} to staging."""
        job = repo + "-stage"
        params = "BRANCH=#{branch}&USER=#{user}"
    httpReq(msg, params, job, message)

  robot.respond /release (.+)/i, (msg) ->
    commandArray = msg.match[1].replace(/^\s+|\s+$/g, "").split(" ")
    repo = commandArray[0]
    if repo == "agents"
        branch = commandArray[1] || "origin/master"
        bump_level = commandArray[2] || "patch"
        env = "prod"
        user = msg.message.user.name
        job = repo + "-prod"
        params = "USER=#{user}&BRANCH=#{branch}&BUMP_LEVEL=#{bump_level}&ENV=#{env}"
        message = """I'm working on deploying agents branch #{branch} to production with patch level #{bump_level}."""
    else if repo == "ng-app"
        level = commandArray[1] || "patch"
        branch = "master"
        destination = "app"
        env = "prod"
        message = """Releasing #{repo} to production with a patch level of #{level}."""
        job = repo
        params = "BRANCH=#{branch}&ENV=#{env}&DESTINATION=#{destination}&LEVEL=#{level}"

    else if repo == "sf-app"
        branch = "master"
        env = "prod"
        message = """Deploying #{repo} branch of #{branch}."""
        job = repo
        params = "BRANCH=#{branch}&ENV=#{env}&DESTINATION=app"

    else if repo == "landing-page"
        branch = "master"
        env = "prod"
        message = """Deploying #{repo} to #{env}."""
        job = repo
        params = "BRANCH=#{branch}&ENV=#{env}"

    else if repo == "support-docs"
        branch = "master"
        env = "prod"
        message = """Deploying #{repo} to #{env}."""
        job = repo
        params = "BRANCH=#{branch}&ENV=#{env}&DESTINATION=support"

    else if repo.match /api-(.+)/i
        user = msg.message.user.name
        branch = commandArray[1] || "master"
        bumpLevel = commandArray[2] || "patch"
        user = msg.message.user.name
        job = repo
        params = "USER=#{user}&BRANCH=#{branch}&ENV=prod&BUMP_LEVEL=#{bumpLevel}"
        message = """I'm working on cutting a release of repo #{repo} with patch level #{bumpLevel}."""
    else if repo.match /services/i
        branch = commandArray[1] || "master"
        user = msg.message.user.name
        message = """Deploying #{repo} #{branch} to prod."""
        job = repo
        params = "BRANCH=#{branch}&USER=#{user}&ENV=prod"
    else
        user = msg.message.user.name
        job = repo + "-master"
        params = ""
        message = """I'm working on cutting a release of repo #{repo}.
        I will let you know when it's ready!"""

    httpReq(msg, params, job, message)

  robot.respond /install\s+agents\b/i, (msg) ->
    agentInstallReq(msg)

  robot.respond /help stage$/i, (msg) ->
    output = """
    thing stage ng-app - Deploy master branch of webapp to unique Pooroku url
    thing stage ng-app <branch> - Deploy a specific branch to a unique Pooroku url
    thing stage ng-app <branch> <name> - Deploy a specific branch to Pooroku with a vanity url
    thing stage sf-app - Deploy master branch of sf-app to stage
    thing stage sf-app <branch> - Deploy a specific branch to stage
    thing stage landing-page - Deploys master branch of landing page with drafts enabled to stage.
    thing stage support-docs - Deploys master branch of support docs to stage.
    thing stage agents - Deploy master branch of agents to staging & notifies all env of a new agent
    thing stage agents <origin/branch |SHA> - Deploy specific branch of agents by either the origin/branch-name or by the SHA to staging & notifies all env of a new agent
    thing stage api-? - Deploy master branch of an api server to staging. Overwrites any existing deployment.
    thing stage api-? <branch> - Deploy a specific branch of an api server to staging. Overwrites any existing deployment.
    thing stage service - Deploy services.
    thing stage service <branch> - Deploy a specific branch of services.
    """
    msg.send output

  robot.respond /help release$/i, (msg) ->
    output = """
    thing release api-? - Releases api server to production from master branch.
    thing release api-? <branch> - Releases a specific branch of api server to production and patch level patch.
    thing release api-? <branch> <patch_level> - Releases a specific branch of api server to production with the specified patch level [patch|minor|major].
    thing release sf-app - Releases master branch of sf-app to production.
    thing release ng-app - Releases master branch of ng-app to production and bumps version a patch level.
    thing release ng-app <patch|minor|major> - Releases master branch of ng-app to production and bumps version a specific level.
    thing release agents - Releases master branch of agents to production with patch version bump.
    thing release agents <origin/branch | SHA> - Releases a specific origin/branch-name or SHA of agents to production with patch version bump.
    thing release agents <origin/branch | SHA> <patch level> - Releases a specific origin/branch-name or SHA of agents to production with patch level specified [patch|minor|major].
    thing release landing-page - Releases master branch of landing page to production.
    thing release support-docs - Releases master branch of support docs to production.
    """

    msg.send output

  robot.respond /help install$/i, (msg) ->
    output = """
    thing install agents [<agent>, ...] [in {envs <id>, ...|all envs}] [for <platform>, ...] use <release> [set {<agent> to <release>}, ...] [allow downgrades]

      \tInstalls the specified agents (all by default) to production. Defaults to environment 1 unless told otherwise.
      \tPlatforms are listed as OS/architecture; use * as a wildcard at either side of the slash. The release set by the
      \t"use" clause will be installed, unless overridden for a specific agent by the "set" clause. (Note that setting
      \tan agent-specific release is pointless unless the agent is also included among those to be installed.) When all
      \tagents and environments are targeted, the release set by "use" will influence the one to be used for new OS
      \thosts as well. When trying to install, please consider whether the versions you request are available for all
      \tplatforms. If they are not, environments with a host for a missing platform will fail (as a whole) cause the
      \tversion can't be satisfied. In such a case you can restrict platforms as required by using the "for" clause.
      \tSome examples follow:

      \tthing install agents use 1.6.25
      \tthing install agents in all envs use 1.6.25
      \tthing install agents vc-mysql-metrics, vc-mysql-query in envs 1, 2, 3 use 1.6.25
      \tthing install agents in all envs for linux/* use 1.6.25
      \tthing install agents for linux/* use 1.6.25
      \tthing install agents use 1.6.25 set vc-agent-007 to 1.6.30, vc-aggregator to 1.6.28
      \tthing install agents vc-mysql-metrics, vc-mysql-query use 1.6.25 set vc-mysql-query to 1.6.30
      \tthing install agents vc-os-metrics use 1.6.1 allow downgrades
      \tthing install agents vc-agent-007, vc-aggregator, vc-os-metrics in all envs for linux/*, freebsd/* use 1.6.30 set vc-agent-007 to 1.6.9

      \tNote: there's a temporary default to linux/* for the platform, cause that's the only thing we're building for
      \tnowadays. This will be removed as soon as we get into automatic builds for other platforms.
    """

    msg.send output

agentInstallReq = (msg) ->
  cmd = /install\s+agents(?:\s+([a-z0-9_-]+(?:\s*,\s*[A-Z0-9_-]+)*))?(?:\s+in\s+(envs\s+\d+(?:\s*,\s*\d+)*|all\s+envs))?(?:\s+for\s+((?:[a-z0-9_-]+|\*)\/(?:[a-z0-9_-]+|\*)(?:\s*,\s*(?:[a-z0-9_-]+|\*)\/(?:[a-z0-9_-]+|\*))*))?\s+use\s+(\d+(?:\.\d+){2,})(?:\s+set\s+([a-z0-9_-]+\s+to\s+(?:\d+(?:\.\d+){2,})(?:\s*,\s*[a-z0-9_-]+\s+to\s+(?:\d+(?:\.\d+){2,}))*))?(?:\s+allow\s+(downgrades))?\s*$/i
  msg.match = msg.message.text.match(cmd)
  if !msg.match
    msg.send "Wrong command buddy. I'd be glad to help install; just let me know!"
    return

  if msg.match[2]
    # We leave envs undefined for "all envs"
    m = msg.match[2].match(/^envs\s+(.*)/)
    envs = m[1].split(/\s*,\s*/) if m
  else
    # Default to 1 (VC's) for safety
    envs = [1]

  release = []
  platforms = ['linux/*'] # temporary default (see help message above)
  agents = msg.match[1].split(/\s*,\s*/) if msg.match[1]
  platforms = msg.match[3].split(/\s*,\s*/) if msg.match[3]
  release = msg.match[5].split(/\s*,\s*/).map((r) -> return r.replace(/\s+to\s+/, ':')) if msg.match[5]
  release.push(":" + msg.match[4])

  p = {}
  p.ENVS = envs.toString() if envs
  p.AGENTS = agents.toString() if agents
  p.PLATFORMS = platforms.toString() if platforms
  p.RELEASE = release.toString() if release && release.length > 0
  p.DOWNGRADES = 1 if msg.match[6]
  p.USER = msg.message.user.name

  params = for name, value of p
    "#{name}=#{value}"
  params = params.join('&')

  message = 'Installing ' + (if agents then agents.join(', ') else 'all agents') +
    ' to ' + (if envs then 'environment(s) ' + envs.join(', ') else 'all environments')
  httpReq(msg, params, 'agents-install', message)

httpReq = (msg, params, job, message) ->
    url = process.env.JENKINS_URL
    job_url = "#{url}job/#{job}/buildWithParameters?#{params}"
    console.log "Sending http request"
    msg.http(job_url)
     .post() (err, res, body) ->
      if err != null
        msg.send err
      else if res.statusCode == 404
        msg.send "I don't know what #{job} is."
      else
        msg.send message
