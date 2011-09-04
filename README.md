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

# Setting up development environment

1. Get a Github account and press <a rel="facebox" class="minibutton btn-fork" href="#fork_box"><span><span class="icon"></span>Fork</span></a>
2. Clone your repo `git clone git@github.com:username/rubypair.git`
3. Prepare
  <pre>
    cd rubypair
    gem install bundler
    bundle install
    cp config/app_config.yml.example config/app_config.yml
  </pre>

4.  [Register your app with Github](http://github.com/account/applications/new) to make authentication work
  - Main URL for development may vary, mine is ```http://localhost:3000``` since I just use Webrick
  - Callback URL is ```http://localhost:3000/auth/github/callback``` adjust your accordingly.
  - Update your `config/app_config.yml` with values supplied from Github's OAUTH app registration
5.  Install MongoDB.  We recommend using [homebrew](https://github.com/mxcl/homebrew)
