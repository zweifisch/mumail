# mumail

sending email using sendmail, using mustache for templating

## usage

```sh
npm install mumail
```

```coffeescript
Mumail = require 'mumail'

mumail = new Mumail
	templatePath: './templates/'
	from: 'noreply@localhost'

mumail.on 'done', ->
	console.log 'mail sent'

mumail.on 'error', (error)->
	console.log error

mumail.send
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
