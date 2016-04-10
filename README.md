# mumail

[![NPM Version][npm-image]][npm-url]

send mail in mustache

## usage

```sh
npm install mumail
```

```coffeescript
Mumail = require 'mumail'

mumail = new Mumail
    templatePath: "#{__dirname}/templates/"
    from: 'noreply@localhost'
    transport:
        host: 'smtp.test.com'
        port: 465
        auth:
            user: "username"
            pass: "password"
        secure: yes

mumail.send
    to: "user@somehost.com"
    subject: "Welcome!"
    template: "welcome"
    data:
        username: 'unique-username'
.then ->
    console.log "sent"
```

`welcome.html` located in `./templates`

```html
<html>
    <body>
        welcome {{username}}
    </body>
</html>
```

[npm-image]: https://img.shields.io/npm/v/mumail.svg?style=flat
[npm-url]: https://npmjs.org/package/mumail
