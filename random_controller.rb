require 'sinatra'
require './app/random_parser'

# add url for your service (used for permalinking)
URL = 'http://rickandmortyquotes.eu-central-1.elasticbeanstalk.com'

class RandomController < Sinatra::Base
  get '/info' do
    'Hello! / returns random quote from a quote_file. /:id returns a specific quote from file'
  end

  get '/' do
    quote = RandomParser.random_entry(file)
    quote['permalink'] = permalink quote['id']

    quote.to_json
  end

  get '/html' do
    quote = RandomParser.random_entry(file)
    quote['permalink'] = permalink quote['id'], html: true

    htmlize quote
  end

  get '/:id' do |id|
    quotes = RandomParser.new(file).quotes
    quotes.select! { |quote| quote['id'] == id }
    quote = quotes[0]
    quote['permalink'] = permalink quote['id']
    puts permalink quote['id']

    quote.to_json
  end

  get '/:id/html' do |id|
    quotes = RandomParser.new(file).quotes
    quotes.select! { |quote| quote['id'] == id }
    quote = quotes[0]
    quote['permalink'] = permalink quote['id'], html: true

    htmlize quote
  end

  private

  def file
    # whatever file you want to use
    file_path = './quotes/rick_and_morty.json'

    # read as file and hand to random_parser
    @file ||= File.read(file_path)
  end

  def permalink(id, html: false)
    return "#{URL}/#{id}/html" if html
    "#{URL}/#{id}"
  end

  def htmlize(quote)
    "
    <h1>Rick and Morty Quotes</h1>
    <p>\"#{quote['what']}\"</p>
    <p> - #{quote['who']}</p>
    <p>#{quote['where']} #{quote['when']}</p>
    <a href=\"#{quote['permalink']}\">Permalink</a>
    "
  end
end

