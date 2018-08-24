require 'octokit'
require 'pp'
require 'csv'

def old_repos(token)
  Octokit.configure do |c|
    c.auto_paginate = true
  end

  client = Octokit::Client.new(access_token: token)

  repos = client.org_repos('opentable', type: 'private')

  puts (CSV.generate do |csv|
    now = Time.now
    repos.sort_by do |r|
      r.created_at
    end.reverse.take(300).each do |r|
      cs = client.contributors(r.full_name)
      if cs != ""
        cs = cs.map(&:login).join(",")
      end

      ts = client.repository_teams(r.full_name) rescue ""
      if ts != ""
        ts = ts.map(&:name).join(",")
      end
      csv << [r.full_name, r.created_at, r.pushed_at, cs, ts]
    end
  end)
end


if $0 == __FILE__
  old_repos(ENV['TOKEN'])
end
