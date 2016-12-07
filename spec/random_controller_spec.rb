require 'spec_helper'
require 'json'
require './random_controller.rb'

RSpec.describe RandomController do
  def app
    RandomController
  end

  describe 'GET /info' do
    it 'returns HELLO API-WORLD' do
      get '/info'
      expect(last_response.status).to eq 200
      expect(last_response.body).to eq 'Hello! / returns random quote from a quote_file. /:id returns a specific quote from file'
    end
  end

  describe 'GET /' do
    before do
      ENV['FILEPATH'] = './quotes/example_quotes.json'
    end

    it 'returns a random json quote from file' do
      get '/'
      expect(last_response.status).to eq 200
      response = last_response.body
      quote = JSON.parse(response)
      expect(quote.class).to eq Hash
      expect(quote.has_key?('who')).to eq true
      expect(quote.has_key?('what')).to eq true
      expect(quote.has_key?('where')).to eq true
      expect(quote.has_key?('when')).to eq true
      expect(quote.has_key?('id')).to eq true
      expect(quote.has_key?('permalink')).to eq true
      expect(quote['permalink'].include?(quote['id'])).to eq true
    end
  end

  describe 'GET /:id' do
    before do
      ENV['FILEPATH'] = './quotes/example_quotes.json'
    end

    context 'with existing id' do
      before do
        @id = 'some_id_to_be_used_for_permalinking'
      end

      it 'returns a specific quote from file' do
        get "/#{@id}"
        expect(last_response.status).to eq 200
        response = last_response.body
        quote = JSON.parse(response)
        expect(quote.class).to eq Hash
        expect(quote.has_key?('who')).to eq true
        expect(quote.has_key?('what')).to eq true
        expect(quote.has_key?('where')).to eq true
        expect(quote.has_key?('when')).to eq true
        expect(quote.has_key?('id')).to eq true
        expect(quote.has_key?('permalink')).to eq true
        expect(quote['permalink'].include?(quote['id'])).to eq true
        expect(quote['id']).to eq @id
      end
    end

    context 'with non-existing id' do
      before do
        @id = 'some_gibberish'
      end

      it 'returns a 404' do
        get "/#{@id}"
        expect(last_response.status).to eq 404
      end
    end
  end

  describe 'get /html' do
    before do
      ENV['FILEPATH'] = './quotes/example_quotes.json'
    end

    it 'returns a html formatted quote' do
      get '/html'
      expect(last_response.status).to eq 200
      quote = last_response.body
      expect(quote.class).to eq String

      expect(quote.include?('some_id_to_be_used_for_permalinking')).to eq true
      expect(quote.include?('who said it')).to eq true
      expect(quote.include?('what was said')).to eq true
      expect(quote.include?('what show / movie / book')).to eq true
      expect(quote.include?('which season / episode / chapter')).to eq true
    end
  end

  describe 'get /:id/html' do
    before do
      ENV['FILEPATH'] = './quotes/example_quotes.json'
    end

    context 'with existing id' do
      before do
        @id = 'some_id_to_be_used_for_permalinking'
      end

      it 'returns a html formatted quote' do
        get "/#{@id}/html"
        expect(last_response.status).to eq 200
        quote = last_response.body
        expect(quote.class).to eq String

        expect(quote.include?('some_id_to_be_used_for_permalinking')).to eq true
        expect(quote.include?('who said it')).to eq true
        expect(quote.include?('what was said')).to eq true
        expect(quote.include?('what show / movie / book')).to eq true
        expect(quote.include?('which season / episode / chapter')).to eq true
      end
    end

    context 'with non-existing id' do
      before do
        @id = 'some_gibberish'
      end

      it 'returns a 404' do
        get "/#{@id}/html"
        expect(last_response.status).to eq 404
      end
    end
  end
end
