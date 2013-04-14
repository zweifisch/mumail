
nodemailer = require 'nodemailer'
fs = require 'fs'
path = require 'path'
hogan = require 'hogan.js'
{EventEmitter} = require 'events'

class Mumail extends EventEmitter

	cachedTemplates = {}

	constructor:({@templatePath,@from})->
		@transport = nodemailer.createTransport 'sendmail'

	send:({from,to,cc,subject,template,data})->

		from = from ? @from
		htmlPath = path.join @templatePath,"#{template}.html"
		textPath = path.join @templatePath,"#{template}.txt"

		opts =
			from: from
			to: to
			subject: subject

		if cc
			opts.cc = cc

		if htmlPath in cachedTemplates
			@renderAndSend opts,cachedTemplates[htmlPath],data
		else
			fs.readFile htmlPath,'utf-8',(err,html)=>
				if err
					@emit 'error', err
				else
					cachedTemplates[htmlPath] = hogan.compile html
					@renderAndSend opts,cachedTemplates[htmlPath],data

	renderAndSend:(opts,template,data)->

			opts.html = template.render data

			@transport.sendMail opts, (error, response)=>
				if error
					@emit 'error', error
				else
					@emit 'done', response

module.exports = Mumail
