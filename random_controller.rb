require 'sinatra'
require './app/random_parser'
require 'uri'
require 'dotenv'

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
    quote = quote_by(id)
    return 404 if quote.nil?
    quote['permalink'] = permalink quote['id']
    puts permalink quote['id']

    quote.to_json
  end

  get '/:id/html' do |id|
    quote = quote_by(id)
    return 404 if quote.nil?
    quote['permalink'] = permalink quote['id'], html: true

    htmlize quote
  end

  private

  def quote_by(id)
    quotes = RandomParser.new(file).quotes
    quotes.select! { |quote| quote['id'] == id }
    quotes[0]
  end

  def file
    Dotenv.load
    file_path = ENV['FILEPATH'] || './quotes/quotes.json'

    # read as file and hand to random_parser
    @file ||= File.read(file_path)
  end

  def permalink(id, html: false)
    return "#{host_url}#{id}/html" if html
    "#{host_url}#{id}"
  end

  def host_url
    URI.join(url, "/").to_s
  end

  def htmlize(quote)
    <<-heredoc
    <h1>Rick and Morty Quotes</h1>
    <p>\"#{quote['what']}\"</p>
    <p> - #{quote['who']}</p>
    <p>#{quote['where']} #{quote['when']}</p>
    <a href=\"#{quote['permalink']}\">Permalink</a>
    heredoc
  end
end

