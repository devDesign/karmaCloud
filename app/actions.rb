get "/" do
  slim :index, :layout => :layout
end

post "/user_session/new" do
  #login user
end

delete "/user_session" do
  #logout user
end

get "/user/:id" do
  #/user/show
  slim :user, :layout => :layout
end

get "/user/new" do
  #/user/new
end

post "/user" do
  #create user
end

get "/story/:id" do
  #/story/show
end

get "/story/new" do
  #/story/new
end

post "/story" do
  #create story
end