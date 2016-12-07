# random_quotes
Random Rick and Morty quotes (or whatever quote_file you wish to supply)

## What is this?
Simple sinatra app that returns a random quote given a provided quotes
file...

## Demo
Running on [aws](http://rickandmortyquotes.eu-central-1.elasticbeanstalk.com/)

![curl demo](https://raw.githubusercontent.com/TPei/random_quotes/master/api_demo.png)

## What can it do
Features:
- [x] `/` returns a random json quote
- [x] json documents supply permalink that corresponds to a `/:id` route on the
  server
- [x] display quote as rendered html version

## Can I use this for anything?
Sure, make your own /awesome/ quotes services by deploying this with a
custom quotes file

### How do I adapt this
I will make this a bit easier in the future, for now:
- provide your own quotes file (json, look at the example_quotes.json)
- link it in the RandomController
- the permalink url is inferred from the current host url
- then simply zip it and upload it to an elasticbeanstalk environment (or
heroku or whatever)

## Contributing
I'd be super psyched if you added some Rick and Morty quotes, seeing as
this is rather tedious work :D

If you do please make sure the format works and there are no duplicate
ids. It's best to keep the json sorted by season/episode.

Also, I'm not sure how tolerant github is towards vulgar language, so
let's not overdo it, alright?^^

## Anything else?
I also made a [Telegram Bot](https://github.com/TPei/Random-Quotes-Telegram-Bot) that you can use to bring these quotes to your Telegram chats.
