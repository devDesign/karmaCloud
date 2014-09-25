
get "/map" do 
  @test = "BAMF!!!!!!!!!!!!"

  gon.test = @test
  
  erb :'map_test'
end

  slim :index, :layout => :layout
end

get "/user" do
  slim :user, :layout => :layout
end

post "/user/new" do
end

get "/story" do
end

post "/story/new" do
end

get "/" do
  slim :index, :layout => :layout
end

