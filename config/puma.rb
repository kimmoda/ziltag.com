# frozen_string_literal: true
key = "#{__dir__}/ssl/localhost.key"
cert = "#{__dir__}/ssl/localhost.crt"
bind "ssl://127.0.0.1:3000?key=#{key}&cert=#{cert}"
