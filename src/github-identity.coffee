# Description:
#   Manage your GitHub identities and tokens.
#
# Configuration:
#
# Commands:
#
# Author
#   tombell
#   mattgraham

module.exports = (robot) ->
  info = url.parse process.env.REDISTOGO_URL or
                   process.env.REDISCLOUD_URL or
                   process.env.REDIS_URL or
                   process.env.BOXEN_REDIS_URL or
                   'redis://localhost:6379'

  client = redis.createClient(info.port, info.hostname)

  robot.respond /who do you know/i, (res) ->
    # TODO: list the chat username to github username associations
    res.reply "This hasn't been implemented yet"

  robot.respond /i am ([a-z0-9-]+)/i, (res) ->
    # TODO: add chat username to github username association
    res.reply "This hasn't been implemented yet"

  robot.respond /forget me/i, (res) ->
    # TODO: remove the chat username to github username association
    res.reply "This hasn't been implemented yet"
