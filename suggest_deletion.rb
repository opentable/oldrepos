require 'octokit'
require 'pp'
require 'csv'
require 'pathname'

def suggest_deletion(token)
  Octokit.configure do |c|
    c.auto_paginate = true
  end

  client = Octokit::Client.new(access_token: token)

  $stdin.each_line do |repo|
    client.create_issue(repo.chomp, "Suggestion: delete repo", suggestion_body(repo))
  end
end

def suggestion_body(repo_name)
  dirname = repo_name.sub(%r[.*/],'')
  return (<<-EOB).gsub(%r[^  ],'')
  Because of our current Github plan, we're tightly restricted on the number of
  private repositories available to us. This repository is one of our oldest,
  and least active.

  Would you please delete this repository to make way for new projects?

  It has already been archived as part of the [Attic repository](https://github.com/opentable/attic).
  You'll notice there's a `#{dirname}` path there. Feel free to confirm that
  all important data is properly archived there.

  This notice was generated automatically by code [here](https://github.com/opentable/oldrepos).
  Feedback on this project is appreciated.

  Thanks again for you attention and cooperation!
  EOB
end

if $0 == __FILE__
  suggest_deletion(ENV['TOKEN'])
end
