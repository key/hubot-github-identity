# Description:
#   Manage your GitHub identities and tokens.
#
# Commands:
#
# Author
#   tombell
#   mattgraham

module.exports = (robot) ->

  unless robot.identity
    robot.identity = require '../lib/identity'
    robot.identity.init()

  robot.respond /who do you know/i, (res) ->
    res.reply "This hasn't been implemented yet"

  robot.respond /i am ([a-z0-9-]+)/i, (res) ->
    chat = res.envelope.user.name
    github = res.match[1]

    robot.identity.setChatUserForGitHubUser chat, github, (err, reply) ->
      # TODO: handle already associated usernames
      if err
        res.reply "Oops: #{err}"
      else if reply
        res.reply "Ok, you are #{github} on GitHub."
      else
        res.reply "Sorry, I don't know of #{github}, maybe you need to register your GitHub username and API token with me?"

  robot.respond /forget me/i, (res) ->
    chat = res.envelope.user.name

    robot.identity.forgetChatUser chat, (err, reply) ->
      if err
        res.reply "Oops: #{err}"
      else if reply
        res.reply "Ok, I have no idea who you are anymore."
      else
        res.reply "Sorry, you haven't let me know your GitHub username."
