# Description:
#   Manage your GitHub identities and tokens.
#
# Commands:
#
# Author
#   tombell
#   mattgraham

module.exports = (robot) ->

  robot.respond /who do you know/i, (res) ->
    res.reply "This hasn't been implemented yet"

  robot.respond /i am ([a-z0-9-]+)/i, (res) ->
    chat = res.envelope.user.name
    github = res.match[1]

    robot.identity.setChatUserForGitHubUser chat, github, (err, reply) ->
      if err
        switch err.type
          when 'redis'
            res.reply "Oops: #{err}"
          when 'chat user'
            res.reply "Sorry, you are already #{err.msg} on GitHub"
          when 'token'
            hostname = process.env.HUBOT_HOSTNAME
            if hostname
              hostname = "#{hostname}/github/identity"
              res.reply "Sorry, I don't know of #{github}, maybe you need to register your GitHub username and API token with me at #{hostname}"
            else
              res.reply "Sorry, I don't know of #{github}, maybe you need to register your GitHub username and API token with me?"
      else
        res.reply "Ok, you are #{github} on GitHub."

  robot.respond /forget me/i, (res) ->
    chat = res.envelope.user.name

    robot.identity.forgetChatUser chat, (err, reply) ->
      if err
        switch err.type
          when 'redis'
            res.reply "Oops: #{err}"
          when 'chat user'
            res.reply "Sorry, you haven't let me know your GitHub username."
      else
        res.reply 'Ok, I have no idea who you are anymore.'
