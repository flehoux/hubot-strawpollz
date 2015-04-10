# Description:
#   Adds Strawpoll functionality to hubot
#
# Dependencies:
#   'querystring'
#
# Configuration:
#   None
#
# Commands:
#   hubot strawpoll -t "<title>" <option1>/<option2>/<option3>/<...> - Create a strapoll with <title> and its <options>

#
# Author:
#   flehoux

STRAWPOLL_TITLE_SPLIT_REGEX = /strawpoll -t "(.*?)" (.+)/i
STRAWPOLL_SPLIT_REGEX = /strawpoll (.+)/i
STRAWPOLL_OPTIONS_REGEX = /([^\/]+)(?:\/)*/i

module.exports = (robot) ->
	robot.respond STRAWPOLL_TITLE_SPLIT_REGEX, (msg) ->
    	msg.reply msg.matches[1]

	robot.respond STRAWPOLL_SPLIT_REGEX, (msg) ->
    	msg.reply msg.matches[1]