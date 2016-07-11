# frozen_string_literal: true
require_relative '../config/environment'
Bundler.require
require 'net/http'
require 'json'

uri = URI('https://www.zopim.com/api/v2/chats')
req = Net::HTTP::Get.new uri
req.basic_auth 'david@ziltag.com',
               'PayYokpY,Phw4LfismHyAzvYcUJGL[34qrobusccM>QaXxmUaK'
res = Net::HTTP.start uri.hostname, uri.port, use_ssl: true do |http|
  http.request req
end
res = JSON.parse(res.body)
visitors = res['chats']
           .map! { |chat| chat['visitor'] }
           .delete_if { |visitor| visitor['email'].empty? }

the_sent = Visitor
           .where(email: visitors.map { |visitor| visitor['email'] })
           .to_a
signed_up_users = User
                  .where(email: visitors.map { |visitor| visitor['email'] })
                  .to_a

visitors.delete_if do |visitor|
  the_sent.index { |x| x.email == visitor['email'] } ||
    signed_up_users.index { |x| x.email == visitor['email'] }
end

if Rails.env.production?
  send_visitor_nurture_email = SendVisitorNurtureEmail.call(visitors)
  Visitor.create(
    send_visitor_nurture_email.context[:result]
                              .map { |sending| { email: sending['email'] } }
  ) if send_visitor_nurture_email.success?
end
