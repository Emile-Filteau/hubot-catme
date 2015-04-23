# Description:
#   Catme is the most important thing in life
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot cat me - Receive a cat
#   hubot cat bomb N - Get N cats
#   hubot cat categories - List all available categories
#   hubot cat (with|in) category - Receive a cat in the given category

module.exports = (robot) ->

  robot.respond /cat( me)?$/i, (msg) ->
    xmlparser = require 'xml2json'
    msg.http("http://thecatapi.com/api/images/get?format=xml")
      .get() (err, res, body) ->
        msg.send JSON.parse(xmlparser.toJson(body)).response.data.images.image.url

  robot.respond /cat bomb( (\d+))?/i, (msg) ->
    xmlparser = require 'xml2json'
    count = msg.match[2] || 5
    count = 100 if count > 100
    msg.http("http://thecatapi.com/api/images/get?format=xml&results_per_page=" + count)
      .get() (err, res, body) ->
        msg.send cat.url for cat in JSON.parse(xmlparser.toJson(body)).response.data.images.image

  robot.respond /cat categories/i, (msg) ->
    xmlparser = require 'xml2json'
    msg.http("http://thecatapi.com/api/categories/list")
      .get() (err, res, body) ->
        msg.send category.name for category in JSON.parse(xmlparser.toJson(body)).response.data.categories.category

  robot.respond /cat( me)? (with|in)( (\w+))?/i, (msg) ->
    xmlparser = require 'xml2json'
    category = msg.match[3] || 'funny'
    msg.http("http://thecatapi.com/api/images/get?format=xml&category="+category)
      .get() (err, res, body) ->
        if JSON.parse(xmlparser.toJson(body)).response.data.images.image
          msg.send JSON.parse(xmlparser.toJson(body)).response.data.images.image.url
        else
          msg.send 'Enter a valid category (type "cat categories" for a list of valid categories)'
