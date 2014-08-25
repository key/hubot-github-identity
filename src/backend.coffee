# Description:
#   Backend that handles the behind the scenes for the web based part of the
#   package.
#
# Author
#   tombell
#   mattgraham

path    = require 'path'
connect = require 'connect'
github  = require '../lib/github'

module.exports = (robot) ->

  # this is a really dirty JS abusing hack that probably should never be used
  # but it let's us put middleware into the stack even after the app has
  # started listening - yolo
  robot.router.stack.splice(robot.router.stack.length - 1, 0, {
    route:  '/github/identity'
    handle: connect.static(path.join(__dirname, '..', 'templates'))
  })

  # verify that the submitted username exists on github
  robot.router.post '/github/identity/username', (req, res) ->
    return res.send 422 unless req.body.username
    github.request "/users/#{req.body.username}", null, (err, data) ->
      return res.send 404 if err?
      res.send data

  robot.router.post '/github/identity/token', (req, res) ->
    return res.send 422 unless req.body.username
    return res.send 422 unless req.body.token
    github.request '/user', req.body.token, (err, data) ->
      return res.send 404 if err?
      res.send data
