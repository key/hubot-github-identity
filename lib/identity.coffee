url = require 'url'

redis = require 'redis'

identity =
  init: ->
    info = url.parse(process.env.REDISTOGO_URL or
                     process.env.REDISCLOUD_URL or
                     process.env.REDIS_URL or
                     process.env.BOXEN_REDIS_URL or
                     'redis://localhost:6379')
    @client = redis.createClient(info.port, info.hostname)

  findToken: (chatUser, callback) ->
    @client.get "ghid:chat:#{chatUser}", (err, githubUser) =>
      return callback(err) if err
      return callback(null, null) unless githubUser

      @client.get "ghid:token:#{githubUser}", callback

  setGitHubUserAndToken: (githubUser, token, callback) ->
    @client.set "ghid:token:#{githubUser}", token, callback

  setChatUserForGitHubUser: (chatUser, githubUser, callback) ->
    @client.get "ghid:chat:#{chatUser}", (err, reply) =>
      return callback(err, null) if err
      return callback(null, null) if reply

      @client.get "ghid:token:#{githubUser}", (err, token) =>
        return callback(err, null) if err
        return callback(null, null) unless token

        @client.set "ghid:chat:#{chatUser}", githubUser, callback

  forgetChatUser: (chatUser, callback) ->
    @client.del "ghid:chat:#{chatUser}", callback

module.exports = identity
