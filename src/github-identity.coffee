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

  robot.respond /who do you know/i, (res) ->
    res.reply "This hasn't been implemented yet"

  robot.respond /i am ([a-z0-9-]+)/i, (res) ->
    res.reply "This hasn't been implemented yet"

  robot.respond /forget me/i, (res) ->
    res.reply "This hasn't been implemented yet"
