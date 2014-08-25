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

module.exports = identity
