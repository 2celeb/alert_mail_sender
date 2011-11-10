# -*- coding: utf-8 -*-
require 'rubygems'
require 'tmail'
require "tlsmail"

class AlertMailSender
  def initialize
    @mail = TMail::Mail.new()
    @mail.to = '<to_address>'
    @mail.from = '<from address>'
    @mail.date = Time.now
    @mail.mime_version = '1.0'
    @mail.set_content_type 'text', 'plain', {'charset'=>'utf-8'}
  end

  def send(&block)
    send = true
    send = block.call(@mail) unless block.nil?
    if send
      Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)
      Net::SMTP.start("smtp.gmail.com", 587, "localhost.localdomain", "<sender_address>", "<password>", "plain") do |smtp|
        smtp.sendmail(@mail.encoded, @mail.from, @mail.to)
      end
    end
  end
end


