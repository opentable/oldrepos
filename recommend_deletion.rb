require 'octokit'
require 'pp'
require 'csv'
require 'pathname'

def recommend_deletion(attic, token, reponame)
  if attic.nil?
    raise "Must set ATTIC_DIR environment variable!"
  end
  if token.nil?
    raise "Must set TOKEN environment variable!"
  end
  if reponame.nil?
    raise "Usage: <reponame>"
  end

  Octokit.configure do |c|
    c.auto_paginate = true
  end

  client = Octokit::Client.new(access_token: token)

  repo = client.repository(reponame)

  if already_encysted(repo, attic)
    raise "Already archived in the attic."
  end

  announce(repo)
  encyst(repo, attic)
  propose(repo, client)
end

def already_encysted(repo, attic)
  Pathname.new(attic).join(repo.name).exist?
end

def announce(repo)
  puts "Let's propose the deletion of #{repo.full_name} (last push was at #{repo.pushed_at})"
end

def encyst(repo, attic)
  %x[cd #{attic}; git subtree add -P #{repo.name} #{repo.ssh_url} master; git push]
end

def propose(repo, client)
  client.create_issue(repo.full_name, "Suggestion: delete repo", suggestion_body(repo))
  File.open("current_proposals", "a+") do |propfile|
    propfile.puts(repo.full_name)
  end
end

def suggestion_body(repo)
  return (<<-EOB).gsub(%r[^  ],'')
  Because of our current Github plan, we're tightly restricted on the number of
  private repositories available to us. This repository is one of our oldest,
  and least active.

  Would you please delete this repository to make way for new projects?

  It has already been archived as part of the [Attic repository](https://github.com/opentable/attic).
  You'll notice there's a `#{repo.name}` path there. Feel free to confirm that
  all important data is properly archived there.

  This notice was generated automatically by code [here](https://github.com/opentable/oldrepos).
  Feedback on this project is appreciated.

  Thanks again for you attention and cooperation!
  EOB
end


if $0 == __FILE__
  recommend_deletion(ENV['ATTIC_DIR'], ENV['TOKEN'], ARGV[0])
end
