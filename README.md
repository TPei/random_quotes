# random_quotes
Random Rick and Morty quotes (or whatever quote_file you wish to supply)

## Demo
Running on [aws](http://rickandmortyquotes.eu-central-1.elasticbeanstalk.com/)

## What is this?
Simple sinatra app that returns a random quote given a provided quotes
file...

## What can it do
Features:
- [x] `/` returns a random json quote
- [x] json documents supply permalink that corresponds to a `/:id` route on the
  server
- [ ] display quote as rendered html version

## Can I use this for anything?
Sure, make your own /awesome/ quotes services by deploying this with a
custom quotes file

### How do I adapt this
I will make this a bit easier in the future, for now:
- provide you own quotes file (json, look at the example_quotes.json)
- link it in the RandomController
- if you have this deployed somewhere and want to have proper
  permalinks, adapt the URL in RandomController to reflect your
environment
- then simply zip it and upload it to an elasticbeanstalk environment (or
heroku or whatever)

## Contributing
I'd be super psyched if you added some Rick and Morty quotes, seeing as
this is rather tedious work :D

If you do please make sure the format works and there are no duplicate
ids. It's best to keep the json sorted by season/episode.

Also, I'm not sure how tolerant github is towards vulgar language, so
let's not overdo it, alright?^^
