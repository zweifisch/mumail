// Generated by CoffeeScript 1.6.3
(function() {
  var EventEmitter, Mumail, fs, hogan, nodemailer, path,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  nodemailer = require('nodemailer');

  fs = require('fs');

  path = require('path');

  hogan = require('hogan.js');

  EventEmitter = require('events').EventEmitter;

  Mumail = (function(_super) {
    var cachedTemplates;

    __extends(Mumail, _super);

    cachedTemplates = {};

    function Mumail(_arg) {
      this.templatePath = _arg.templatePath, this.from = _arg.from;
      this.transport = nodemailer.createTransport('sendmail');
    }

    Mumail.prototype.send = function(_arg) {
      var cc, data, from, opts, subject, template, to,
        _this = this;
      from = _arg.from, to = _arg.to, cc = _arg.cc, subject = _arg.subject, template = _arg.template, data = _arg.data;
      from = from != null ? from : this.from;
      opts = {
        from: from,
        to: to,
        subject: subject
      };
      if (cc) {
        opts.cc = cc;
      }
      console.log(template);
      return this.render(template, data, function(html) {
        return _this.sendMail(opts, html);
      });
    };

    Mumail.prototype.sendMail = function(opts, html) {
      var _this = this;
      opts.html = html;
      return this.transport.sendMail(opts, function(error, response) {
        if (error) {
          return _this.emit('error', error);
        } else {
          return _this.emit('done', response);
        }
      });
    };

    Mumail.prototype.render = function(templateName, data, callback) {
      var htmlPath, textPath,
        _this = this;
      htmlPath = path.join(this.templatePath, "" + templateName + ".html");
      textPath = path.join(this.templatePath, "" + templateName + ".txt");
      if (cachedTemplates[htmlPath]) {
        return callback(cachedTemplates[htmlPath].render(data));
      } else {
        return fs.readFile(htmlPath, 'utf-8', function(err, html) {
          if (err) {
            return _this.emit('error', err);
          } else {
            cachedTemplates[htmlPath] = hogan.compile(html);
            return callback(cachedTemplates[htmlPath].render(data));
          }
        });
      }
    };

    return Mumail;

  })(EventEmitter);

  module.exports = Mumail;

}).call(this);
