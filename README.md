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

TODO:
- When deleting pending members, send an email to an admin account with the members details. I accidentally deleted a pending member for some reason and a subsequent payment has come through the system which I'm now unable to reconcile.
- Introduce a 'six month' membership for anyone who signs up after july 1
- Import: http://web.archive.org/web/20060821203255/http://basketball.musa.net.au/contact/index.php
- fix signup form to make email address mandatory
- fix signup form for IE8
- add filesize to PDF links
- consider using stripe instead of paypal
- add recent facebook comments widget on homepage
- make the homepage news items links work
- add a 'more articles' link at the bottom of the homepage news
- add a 'recently updated pages' table to the homepage
- move 'upcoming events' into a new bar on the homepage
- add an extra panel that links to 'sticky' articles (eg. tournaments, newsletters)
- add sponsors to the homepage
- add a 'favourite articles' link section to the homepage eg. http://espn.go.com/espn/story/_/page/Michael-Jordan/michael-jordan-not-left-building
- face detection: https://devcenter.heroku.com/articles/cloudinary ?
- Have life members automatically renewed each year (or some variation of this).
NOT DOING - MUSA CAN PAY FOR THIS- Thanks for the membership data, could the club please adjust your online form for next year so current students can indicate whether they are engaged in under or post grad studies

DONE - add 'date_payment_acknowledged' data to CSV spreadsheet
DONE - changing email addresses in admin is setting amount paid to $0
DONE - The $10 late fee be removed for the summer season. So, for example, people who sign up after 1 August don't pay the late fee
