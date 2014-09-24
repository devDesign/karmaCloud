get "/" do
  slim :index, :layout => :layout
end

get "/user" do
  slim :user, :layout => :layout
end

post "/user/new" do
end

get "/story" do
  slim :, :layout => :layout
end

post "/story/new" do
end

get "/" do
  slim :index, :layout => :layout
end

