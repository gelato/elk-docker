#!/usr/bin/env ruby
# encoding: utf-8

require "rubygems"
require "bunny"

conn = Bunny.new(:host => "192.168.0.170", :vhost => "logstash", :user => "logstash", :password => "logmqstash")
conn.start

ch = conn.create_channel
q = ch.queue("logstash", :durable => true)
ch.default_exchange.publish("Hello World!", :routing_key => "logstash")
puts " [x] Sent 'Hello World!'"
sleep 1.0
conn.close

