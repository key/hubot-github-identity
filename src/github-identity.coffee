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

  unless robot.identity
    robot.identity = require '../lib/identity'
    robot.identity.init()

  robot.respond /who do you know/i, (res) ->
    # TODO: list the chat username to github username associations
    res.reply "This hasn't been implemented yet"

  robot.respond /i am ([a-z0-9-]+)/i, (res) ->
    # TODO: add chat username to github username association
    res.reply "This hasn't been implemented yet"

  robot.respond /forget me/i, (res) ->
    # TODO: remove the chat username to github username association
    res.reply "This hasn't been implemented yet"
