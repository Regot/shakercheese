require 'sinatra'
require './config/init.rb'

get "/" do
  erb :index, :layout => :"layouts/layout"
end