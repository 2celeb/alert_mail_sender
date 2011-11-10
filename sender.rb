# -*- coding: utf-8 -*-
require "./alert_mail_sender.rb"
AlertMailSender.new().send do |mail|

  result = `ls -l`
  result== "error" if result.empty?

  mail.body = result
  mail.subject = "ls結果"

end
