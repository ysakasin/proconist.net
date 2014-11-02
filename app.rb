# coding: utf-8
require 'sinatra'
require 'slim'

get '/' do
  @title = 'Proconist.net'
  slim :index
end
