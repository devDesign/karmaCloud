
get "/map" do 
  
  # Request to server for stories published in last 24 hours
  # Pass array of objects via gon.variable = @variable

  gon.stories = [
    {
      lat: 49.281956099999995,
      lon: -123.108346,
      content: "Story content",
      posted_by: "some user"
    },

    {
      lat: 50.2819561,
      lon: -123.1083461,
      content: "Story content",
      posted_by: "some user"
    },

    {
      lat: 49.2819562,
      lon: -123.1083462,
      content: "Story content",
      posted_by: "some user"
    },

    {
      lat: 49.2819563,
      lon: -124.1083463,
      content: "Story content",
      posted_by: "some user"
    },

    {
      lat: 49.63,
      lon: -123.1083464,
      content: "Story content",
      posted_by: "some user"
    },

    {
      lat: 49.2819563,
      lon: -123.108,
      content: "Story content",
      posted_by: "some user"
    }
  ]
  
  erb :'map_test'
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

