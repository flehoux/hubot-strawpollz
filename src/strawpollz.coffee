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
#   hubot strawpollz -t "<title>" <option1>/<option2>/<option3>/<...> - Create a strawpoll with <title> and its <options>
#   hubot strawpollz <option1>/<option2>/<option3>/<...> - Create a strawpoll with its <options>

#
# Author:
#   flehoux

querystring = require 'querystring'

STRAWPOLL_URL = 'http://strawpoll.me/api/v2/polls'
STRAWPOLL_HEADER = {'X-Requested-With': 'XMLHttpRequest', 'Content-Type': 'application/x-www-form-urlencoded'}
STRAWPOLL_REGEX = /strawpollz (?:(-t) "(.*?)")?(.+)/i

build_data = (title, options) ->
	querystring.stringify {
		title: title,
		options: options,
		permissive: true
	}

module.exports = (robot) ->
	robot.respond STRAWPOLL_REGEX, (msg) ->
    	title = if msg.match[1] == '-t' then msg.match[2] else 'Poll' + Math.floor(Math.random() * 1000)
    	options = msg.match[3].split '/'
    	data = build_data title, options
    	req = robot.http(STRAWPOLL_URL).headers(STRAWPOLL_HEADER).post(data) (err, res, body) ->
    		if err
    			msg.send('Error:' + err);
				return;
			msg.reply('http://strawpoll.me/' + JSON.parse(body)['id'])