require 'sinatra'
require './config/init.rb'

get "/?:stuff" do
  @stuff = params[:stuff]
  erb :index, :layout => :"layouts/layout"
end