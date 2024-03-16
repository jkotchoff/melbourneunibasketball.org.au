<p align="center">
  <img src="doc/mubc_logo.png"><br/>
  <h2 align="center">melbourneunibasketball.org.au</h2>
</p>

This is the Ruby on Rails source code for [melbourneunibasketball.org.au](https://melbourneunibasketball.org.au)

## Development Environment

```
git clone git@github.com:jkotchoff/melbourneunibasketball.org.au.git
export PAYPAL_LOGIN="..."
export PAYPAL_PASSWORD="..."
export PAYPAL_SIGNATURE="..."
export ADMIN_USERNAME="..."
export ADMIN_PASSWORD="..."
```

## Deployment

```
heroku config:add PAYPAL_LOGIN="..."
heroku config:add PAYPAL_PASSWORD="..."
heroku config:add PAYPAL_SIGNATURE="..."
heroku config:add ADMIN_USERNAME="..."
heroku config:add ADMIN_PASSWORD="..."
```


## Related links

- Website URL: https://melbourneunibasketball.org.au
- Staging Test environment: https://mubc-staging.herokuapp.com
- Stripe: https://dashboard.stripe.com
- Documentation: https://docs.google.com/document/d/1h4MdG9zwtAxqLCsRpVpgZdGaDhKGJvyI8zAL3rQoQiY/edit (viewable by the MUBC committee per the `..@melbourneuni.org.au` google domain administrative permissions)

## TODO:
- Automate newsletter uploading from a PDF document to S3 / website
- Create a report that lists email addresses of last years members who are not signed up for this year yet
- Make student number compulsory on the MUBC signups form
- adjust the date for which membership prices are reduced? (currently august 1st - Phil sent an email about this on July 19th *2016?*
- make photo upload mandatory for new members
- show old photos for members
- show undergraduate / postgrad fields
- Allow member approval to adjust the amount paid (ie. for big v players)
- Introduce a 'six month' membership for anyone who signs up after july 1
- Introduce a $20 'social' membership for anyone who just wants to train (this shouldn't be used in team list selection), refer 'So Sum' in 2017
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
- MUSA request: Thanks for the membership data, could the club please adjust your online form for next year so current students can indicate whether they are engaged in under or post grad studies
- administer and release a monthly 'dribbling balls' newsletter
- update sponsors on website
- manage game day programs and visiting/away team welcome notes
- create a 'season' big v page for each team
  Include a html table containing:
  - opposition name
  - link to big v stats page
  - link to live stats page
  - round number
  - youtube link to game
  - big v video links (with a minute:second offset remark for the Melbourne Uni section)
  - game day program link
- clean up the big v page on the website
- update the sponsors page on the website with player sponsors
- interview player per week to put in the game day program (include a photo)
- create an operational document to describe duties
- upload big v game footage
- delete old website news articles that are redundant
- email sponsors one or two updates per year about their exposure
- update social media with sponsorship details
- update social media with weekly club news
- interview and publish player profiles
- record, edit and publish domestic finals for youtube
- formalise and document all administrative and volunteer roles for the club in google docs

DONE - add 'date_payment_acknowledged' data to CSV spreadsheet
DONE - changing email addresses in admin is setting amount paid to $0
DONE - The $10 late fee be removed for the summer season. So, for example, people who sign up after 1 August don't pay the late fee
