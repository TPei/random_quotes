require 'sinatra'
require './app/random_parser'

class RandomController < Sinatra::Base
  get '/info' do
    'HELLO API-WORLD'
  end

  get '/' do
    # whatever file you want to use
    file_path = './quotes/rick_and_morty.json'

    # read as file and hand to random_parser
    file = File.read(file_path)
    RandomParser.random_entry(file).to_json
  end
end

