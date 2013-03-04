
Mumail = require '../mumail'

muMail = new Mumail
	templatePath: './templates/'
	from: 'noreply@localhost'

muMail.on 'done', ->
	console.log 'mail sent'

muMail.on 'error', (error)->
	console.log error

muMail.send
	to: "user@somehost.com"
	subject: "Welcome!"
	template: "welcome"
	data:
		username: 'unique-username'
