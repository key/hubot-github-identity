# hubot-github-identity

Using any Hubot scripts to interact with GitHub?

Most likely those scripts authenticate as a single user. So when Hubot calls the
GitHub API it's as that user, and not the person who said the command.

This isn't the ideal solution if you want multiple users using these scripts.

Our solution is the let people identify themselves using a private web based
form served by Hubot.

People add their GitHub username and API token so they can identify themselves
and have Hubot run commands on their behalf when using scripts for GitHub.

![Registering API Token](docs/screenshot.png)

## Installation

  * Add `"hubot-github-identity":""` to your `package.json` file.
  * Add `hubot-github-identity` to your `external-scripts.json` file.

**Note: your Hubot should be using the built in Express server.**

## Configuration

This package requires a Redis instance.

The URL for the Redis instance should be set in any of the following environment
variables:

  * `REDISTOGO_URL`
  * `REDISCLOUD_URL`
  * `REDIS_URL`
  * `BOXEN_REDIS_URL`

If none are supplied it fallsback to using `redis://localhost:6379`. If you are
already using the `redis-brain.coffee` script, you should already have this
environment variable configured.

## Usage

Once you've got `hubot-github-identity` added, when you launch Hubot a simple
page will be available at `http://{hostname}:{port}/github/identity`.

It will prompt you to enter your GitHub username followed by a GitHub API token
you would like Hubot to use on your behalf.

**Note: these tokens are stored in Redis, but not in the brain data.**

Once you've added your GitHub username and token you will be able to tell Hubot
in your chat what your GitHub username is, this is so Hubot knows which chat
user you are.

  > Tom Bell > hubot i am tombell

  > Hubot > Tom Bell: Ok, you are tombell on GitHub.

Now in your scripts you will be able to get a GitHub API token for a user by
using the `robot.identity.findToken()` function.

**Note: this function is added during script loading, you should not assume the
function exists until all scripts have finished loading.**

```coffeescript
robot.respond /make some github api request for me/i, (res) ->
  robot.identity.findToken res.envelope.user.name, (err, token) ->
    # ...
```

The `err` parameter will contain an object with error details if there is an
error. The `type` property will tell you what the error relates to.

  * `type: 'redis'` there was an issue with communicating with Redis
  * `type: 'github user'` the user hasn't told Hubot their GitHub username

## See Also

Scripts utilizing `hubot-github-identity`.

  * Coming soon

If you build a script package that integrates with `hubot-github-identity`,
open an issue and we'll add you to the list above.
