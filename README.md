# melbourneunibasketball.org.au

This is the Ruby on Rails sourcecode behind melbourneunibasketball.org.au

## Development Environment

$ git clone git@github.com:cornflakesuperstar/melbourneunibasketball.org.au.git
$ export PAYPAL_LOGIN="..."
$ export PAYPAL_PASSWORD="..."
$ export PAYPAL_SIGNATURE="..."
$ export ADMIN_USERNAME="..."
$ export ADMIN_PASSWORD="..."

## Deployment

$ heroku config:add PAYPAL_LOGIN="..."
$ heroku config:add PAYPAL_PASSWORD="..."
$ heroku config:add PAYPAL_SIGNATURE="..."
$ heroku config:add ADMIN_USERNAME="..."
$ heroku config:add ADMIN_PASSWORD="..."
