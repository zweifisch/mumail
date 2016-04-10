Mumail = require '../index'
path = require 'path'

mumail = new Mumail
    templatePath: path.join __dirname, 'templates'
    from: 'noreply@localhost'

console.log "sending email to #{process.argv[2]}"

mumail.send
    to: process.argv[2]
    subject: "Welcome!"
    template: "welcome"
    data:
        username: 'unique-username'
.then ->
    console.log 'mail sent'
.catch (error)->
    console.log error
