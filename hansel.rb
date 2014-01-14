require 'sinatra'
require './config/init.rb'

# ROUTES
get "/" do
  # META INFO
  @page_title = "Testing Stuff"
  @page_description = "Stuff"
  @page_site_name = "More Stuff"

  # PAGE LEVEL DATA
  @users = User.order("created_at DESC")
  redirect "/new_user" if @users.empty?
  erb :index, :layout => :"layouts/layout2"
end

get "/new_user" do
  # META INFO
  @page_title = "Testing Stuff"
  @page_description = "Stuff"
  @page_site_name = "More Stuff"

  # PAGE LEVEL DATA
  erb :new_user, :layout => :"layouts/layout"
end

post "/new_user" do
  # META INFO
  @page_title = "Testing Stuff"
  @page_description = "Stuff"
  @page_site_name = "More Stuff"

  # PAGE LEVEL DATA
  @user = User.new(params[:user])
  if @user.save
    redirect "user/#{@user.id}"
  else
    erb :new_user, :layout => :"layouts/layout"
  end
end

get "/user/:id" do
  # META INFO
  @page_title = "Testing Stuff"
  @page_description = "Stuff"
  @page_site_name = "More Stuff"

  # PAGE LEVEL DATA
	@test = UserController.new
  @user = User.find_by_id(params[:id])
  erb :user, :layout => :"layouts/layout"
end

# LINKS
get "/new_link/:id" do
  # META INFO
  @page_title = "Testing Stuff"
  @page_description = "Stuff"
  @page_site_name = "More Stuff"

  # PAGE LEVEL DATA
  @id = params[:id]
  erb :new_link, :layout => :"layouts/layout"
end

post "/new_link" do
  # META INFO
  @page_title = "Testing Stuff"
  @page_description = "Stuff"
  @page_site_name = "More Stuff"

  # PAGE LEVEL DATA
  @link = Link.new(params[:link])
  if @link.save
    redirect "link/#{@link.id}"
  else
    erb :new_link, :layout => :"layouts/layout"
  end
end

get "/link/:id" do
  # META INFO
  @page_title = "Testing Stuff"
  @page_description = "Stuff"
  @page_site_name = "More Stuff"

  # PAGE LEVEL DATA
  @link = Link.find_by_id(params[:id])
  erb :link, :layout => :"layouts/layout"
end


############ SAMPLE ROUTE ############
get "/tempypoo" do
  # META INFO
  @page_title = "Testing Stuff"
  @page_description = "Stuff"
  @page_site_name = "More Stuff"

  # PAGE LEVEL DATA
  erb :sample, :layout => :"layouts/layout"
end