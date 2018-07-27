# Old Projects

These are Ruby scripts
that use the Octokit library
to interrogate Github
and try to help ease the issues
that we've had with our private repos limit.

## Script Catalogue

`ruby propose_deletion.rb` interrogates our repos,
looking for the 10 repos
whose last push was longest ago.
It archives those repos as a subtree of our Attic,
adds an issue to the repo suggesting that it be deleted,
and records the name of the repo to
a file called `current_proposals`.

`ruby monitor_proposals.rb` iterates over
the `current_proposals` file,
checking if they're still there
and enumerating their committers
(on the grounds that they may be reachable to delete the repo)
and recording a new file
called `still_active`.
After running it,
you can `mv still_active current_proposals`.

There are some other scripts here
which were mostly experimental.
The should probably be removed.

## Configuration

You'll need to set two environment variables
in order for these scripts to work:
`TOKEN` is a Github token with "read" permissions
over (at least) repos.
If the scriptshave permission issues
you'll need to broaden the permissions needed.
`ATTIC_DIR` is the path to a checkout of the attic repo.
I use `direnv` to configure these,
but that's up to you.
