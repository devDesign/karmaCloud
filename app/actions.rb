get "/" do
  slim :index
end

get "/map" do 
  send_file '/test.html'
end