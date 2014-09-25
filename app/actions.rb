get "/" do
  slim :index
end

get "/map" do 
  @test = "BAMF!!!!!!!!!!!!"

  gon.test = @test
  
  erb :'map_test'
end