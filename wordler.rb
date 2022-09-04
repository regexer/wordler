#!/usr/bin/env ruby

require 'sinatra/base'
require './lib/wordle.rb'
require 'json'
require 'yaml'

class Wordler < Sinatra::Base

  wordle = Wordle.new './data/nytwordle.json'

  get '/' do
    self.help(uri, request.path)
  end

  get '/wordle.?:format?' do
    return self.help(uri, request.path) if params['letters'].nil?
    letters = params['letters'].upcase
    positional = validate params['positional']
    if(letters.length > 5)

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
    return self.help(uri, request.path) if params['letters'].nil?
    letters = params['letters'].upcase
    positional = validate params['positional']
    if(letters.length > 5)

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

  def validate positional
    case positional
    when nil?
      return true
    when /true/i
      return true
    when /false/i
      return false
    else
      return true
    end
  end


  def help uri, request_path
    endpoint = uri.sub(request_path, '')
    headers['Content-Type'] = 'text/plain'
    <<HELP
    Call the service like this:

    #{endpoint}wordle.json?letters=LEDGE
HELP
  end

end
