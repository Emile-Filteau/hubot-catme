# Description:
#   cat me is the most important thing in life
#
# Dependencies:
#   "cheerio": "~0.19.0"
#
# Configuration:
#   None
#
# Commands:
#   hubot cat me - Receive a cat
#   hubot cat bomb N - Get N cats
#   hubot cat categories - List all available categories
#   hubot cat (with|in) category - Receive a cat in the given category
$ = require 'cheerio'

module.exports = (robot) ->

  robot.respond /(cat|dog)( me)?$/i, (msg) ->
    apiName = msg.match[1]
    msg.http("https://api.the" + 
      apiName + 
      "api.com/api/images/get?format=xml")
      .get() (err, res, body) ->
        msg.send $(body).find('url').text()

  robot.respond /(cat|dog) bomb( (\d+))?/i, (msg) ->
    apiName = msg.match[1]
    count = msg.match[2] || 5
    count = 100 if count > 100
    msg.http("https://api.the" + 
      apiName + 
      "api.com/api/images/get?format=xml&results_per_page=" 
      + count)
      .get() (err, res, body) ->
        msg.send $(cat).find('url').text() for cat in $(body).find('image')

  robot.respond /(cat|dog) categories/i, (msg) ->
    apiName = msg.match[1]
    msg.http("https://api.the" +
      apiName +
      "api.com/api/categories/list")
      .get() (err, res, body) ->
        msg.send $(category).find('name').text() for category in $(body).find('category')

  robot.respond /(cat|dog)( me)?( (with|in))( (\w+))?/i, (msg) ->
    apiName = msg.match[1]
    category = (msg.match[5] || 'funny').trim()
    msg.http("https://api.the" +
      apiName +
      "api.com/api/images/get?format=xml&category="+category)
      .get() (err, res, body) ->
        if $(body).find('url').length
          msg.send $(body).find('url').text()
        else
          msg.send 'Enter a valid category (type "cat categories" for a list of valid categories)'
