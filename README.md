# Overview
This is an idea that came up during a break at a daylong session at Lone Star Ruby Conference and I quick registered the domain name. I thought it would be fun to find people who are willing to pair program in your area. So this is this start of such a project. Hopefully I can find others to help me with it and get it going (and keep me on it).

## Plan:
* Page where Developers can login and make a profile, including the following:
  - twitter, linked in profiles, github
  - areas of code you like (tests, views, database, etc)
  - city, state (optional)
  - prefer in-person, online pair programming, or either
  - link to coderwall
* Comment on profile (talk positively how it was to pair with that person)

## Future:
* Maybe a reward system (stars? rubyies?) that people can award someone who was helpful. Maybe sponsors can offer prizes.

# Get up and running

1.  Fork the repo [It's just this easy](http://help.github.com/fork-a-repo/)
2.  Clone your shiny new repo ```git clone git@github.com:username/rubypair.git```
3.  Get you some bundler ```gem install bundler```
4.  Get you some gems ```bundle install```
5.  Copy the example config file into the config directory ```cp config/app_config.yml.example config/app_config.yml```
6.  Register your application (This makes authentication work) [Register Here!](http://github.com/account/applications/new)
  - Main URL for development may vary some but mine is ```http://localhost:3000``` since I just use Webrick
  - Callback URL is ```http://localhost:3000/auth/github/callback``` adjust your accordingly.
7.  Update your config/app_config.yml with values supplied rom Github's OAUTH app registration
8.  Install MongoDB.  We recommend using [homebrew](https://github.com/mxcl/homebrew)
9.  There is no 9!
