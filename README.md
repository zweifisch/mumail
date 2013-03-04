# mumail

sending email using sendmail, using mustache for templating

## usage

```sh
npm install mumail
```

```coffeescript
Mumail = require 'mumail'

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
```

`welcome.html` located in `./templates`
```html
<html>
	<body>
		welcome {{username}}
	</body>
</html>
```
