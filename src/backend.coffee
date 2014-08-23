# Description:
#   Manage your GitHub identities and tokens.
#
# Author
#   tombell
#   mattgraham

path = require 'path'

connect = require 'connect'

module.exports = (robot) ->

  # this is a really dirty JS abusing hack that probably should never be used
  # but it let's the put middleware into the stack even after the app has
  # started listening - yolo
  robot.router.stack.splice(robot.router.stack.length - 1, 0, {
    route:  '/github/identity'
    handle: connect.static(path.join(__dirname, '..', 'templates'))
  })
