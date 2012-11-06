require 'rubygems'
require 'sinatra'
require 'coffee-script'

get '/' do
  erb :bubble_sort
end