require 'octokit'
require 'pp'
require 'csv'

A_YEAR = 60 * 60 * 24 * 365

def old_repos(token)
  Octokit.configure do |c|
    c.auto_paginate = true
  end

  client = Octokit::Client.new(access_token: token)

  repos = client.org_repos('opentable', type: 'private')

  puts (CSV.generate do |csv|
    now = Time.now
    repos.find_all do |r|
      now - r.pushed_at > A_YEAR
    end.sort_by do |r|
      r[:pushed_at]
    end.each do |r|
      csv << [r[:full_name], r[:pushed_at]]
    end
  end)
end


if $0 == __FILE__
  old_repos(ENV['TOKEN'])
end
