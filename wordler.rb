#!/usr/bin/env ruby

require 'sinatra/base'
require './lib/wordle.rb'
require 'json'
require 'yaml'
require 'pry'

class Wordler < Sinatra::Base

  wordle = Wordle.new './data/nytwordle.json'
  #mywords1 = wordle.get_words("Q")
  #mywords2 = wordle.get_words("Q", 3)

  get '/' do
    headers['Content-Type'] = 'text/plain'
    <<HELP
    Call the service like this:

    #{uri}wordle.json?letters=LEDGE
HELP
  end

  get '/wordle.?:format?' do
    letters = params['letters'].upcase
    positional = params['positional'] || true
    if(letters.length > 5 || (!positional && letters.length <= 5 && letters.length > 0))
      if params['format'] == 'json'
        content_type 'json'
        { :status => 'error', :msg => "Sorry, wordle uses 5-letter words only." }.to_json
      else
        content_type 'text'
        return "Sorry, wordle uses 5-letter words only."
      end
    end
    words = (wordle.get_words(letters, positional)).sort
    if params['format'] == 'json'
      content_type 'json'
      { :positional => positional, :words => words }.to_json
    elsif params['format'] == 'yaml'
      content_type 'yaml'
      { :positional => positional, :words => words }.to_yaml
    else
      content_type 'text'
      words.join("\n")
    end
  end

  post '/wordle.?:format?' do
    letters = params['letters'].upcase
    positional = params['positional'] || true
    if(letters.length > 5 || (!positional && letters.length <= 5 && letters.length > 0))
      if params['format'] == 'json'
        content_type 'json'
        { :status => 'error', :msg => "Sorry, wordle uses 5-letter words only." }.to_json
      else
        content_type 'text'
        return "Sorry, wordle uses 5-letter words only."
      end
    end
    words = (wordle.get_words(letters, positional)).sort
    if params['format'] == 'json'
      content_type 'json'
      { :positional => positional, :words => words }.to_json
    elsif params['format'] == 'yaml'
      content_type 'yaml'
      { :positional => positional, :words => words }.to_yaml
    else
      content_type 'text'
      words.join("\n")
    end
  end

  private
  #def respond msg, format
    #
  #end

end
