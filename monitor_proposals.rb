require 'octokit'
require 'pp'
require 'csv'
require 'pathname'

NUMBER = 10

def review_proposals(token)
  if token.nil?
    raise "Must set TOKEN environment variable!"
  end

  Octokit.configure do |c|
    c.auto_paginate = true
  end

  client = Octokit::Client.new(access_token: token)

  File.open("current_proposals", "r") do |file|
    file.each_line do |line|
      review(line.chomp, client)
    end
  end
end

def review(reponame, client)
  repo = client.repository(reponame)
  puts "Repository #{reponame} still exists. Last pushed at #{repo.pushed_at}"
  client.contributors(reponame).map do |c|
    c = client.user(c.login)
    pp [c.login, c.name, c.email]
  end

rescue Octokit::InvalidRepository
  puts "Good news: #{reponame} is no longer a valid repo!"
rescue => ex
  p ex
end

if $0 == __FILE__
  review_proposals(ENV['TOKEN'])
end
