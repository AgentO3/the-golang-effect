job {
  name "send-message-to-thing"

  logRotator(1)

  parameters {
    stringParam("MESSAGE")
    stringParam("ROOM", "36114_vividcortex@conf.hipchat.com")
  }

  steps {
    shell('curl -v -X POST localhost:5555/hubot/say -d room="$ROOM" -d message="$MESSAGE"')
  }
}
