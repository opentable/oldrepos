require 'octokit'
require 'pp'
require 'csv'

def old_repos(token)
  Octokit.configure do |c|
    c.auto_paginate = true
  end

  client = Octokit::Client.new(access_token: token)

  ot = client.organization_members('opentable')
  puts (CSV.generate headers: ["Login", "Name", "Public repo count", "Location", "Email", "Github URL"] do |csv|
    ot.each do |user|
      user = client.user(user.login)
      fields = [user.login, user.name, user.public_repos, user.location, user.email, user.url]
      csv << fields
    end
  end)
end

if $0 == __FILE__
  old_repos(ENV['TOKEN'])
end
