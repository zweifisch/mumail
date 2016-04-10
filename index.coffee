nodemailer = require 'nodemailer'
fs = require 'fs'
path = require 'path'
mustache = require 'mustache'
_ = require 'lodash'

class Mumail

    cachedTemplates = {}

    constructor: ({@templatePath, @from, transport})->
        @transport = nodemailer.createTransport transport
        @transport.verify()

    send: (options)->
        {template, data, from} = options
        @render(template, data).then (html)=>
            @transport.sendMail _.assign html: html, from: @from, _.omit options, ["template", "data"]

    render: (templateName, data)->
        htmlPath = path.join @templatePath, "#{templateName}.html"
        textPath = path.join @templatePath, "#{templateName}.txt"

        new Promise (resolve, reject)->
            if cachedTemplates[htmlPath]
                resolve mustache.render cachedTemplates[htmlPath], data
            else
                fs.readFile htmlPath, 'utf-8', (err, html)=>
                    if err
                        reject err
                    else
                        cachedTemplates[htmlPath] = html
                        resolve mustache.render html, data

module.exports = Mumail
