get '/stylesheets/style.css' do
  scss :styles
end

get "/map" do 
  
  # Request to server for stories published in last 24 hours
  # Pass array of objects via gon.variable = @variable

  
  
  erb :'map_test'
end

helpers do

  def encrypt(input)
    Digest::SHA1.hexdigest(input) unless input.blank?
  end

  def login_valid?
    return true unless @user.password != encrypt(params[:password])
  end
end

get "/" do

  gon.stories = [
    {
      lat: 49.281956099999995,
      lon: -123.108346,
      content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras sed sapien vel mauris aliquet commodo. Pellentesque non lacus ante. Nunc nibh lectus, dapibus ut fringilla sit amet, lacinia sit amet magna. Nam rhoncus lectus eu nunc efficitur viverra. Phasellus pellentesque eget orci vel ultricies. Phasellus in odio in tellus fermentum hendrerit sed a ante. Cras dignissim, ex gravida vestibulum finibus, odio justo condimentum libero, id finibus mi elit sit amet enim. Quisque vulputate viverra eros, at viverra nibh pretium ac. Duis molestie ante vitae elit pellentesque, at fringilla nisi congue. Pellentesque sagittis rhoncus pellentesque. Vivamus scelerisque, mauris vitae interdum fermentum, orci massa pharetra massa, ultricies efficitur odio arcu eu sem. Nam suscipit nulla sed ipsum lacinia, eu imperdiet ante condimentum. Proin accumsan cursus ligula, vel luctus libero lacinia sit amet.",
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
  

  erb :index, :layout => :'../layout'

end

post "/user_session/new" do
  @user = User.where(user_name: params[:user_name]).first || User.new
  if login_valid?
    session[:user_id] = @user.id
    redirect '/'
  else
    @login_errors = true
    slim :index, layout: :layout
  end
end

delete "/user_session" do
  session[:user_id] = nil
  redirect '/'
end

get "/user/new" do
  @user = User.new
  slim :'/user/new', layout: :layout
end


get "/user/:id" do
  @user = User.find(params[:id])
  slim :'user/show', layout: :layout
end

post "/user" do
  @user = User.new(
    user_name: params[:user_name],
    password:  encrypt(params[:password]),
    email:     params[:email]
    )
  if @user.save
    session[:user_id] = @user.id
    redirect '/'
  else
    slim :'/user/new', layout: :layout
  end
end

get "/story/new" do
  @story = Story.new
  slim :'story/new', layout: :layout
end

get "/story/:id" do
  slim :'story/show', layout: :layout
end

post "/story" do
  @location_query
  @user = User.find(session[:user_id])
  @story = @user.stories.new(
    title:    params[:title],
    content:  params[:content],
    mood:     params[:mood],
    location: params[:location]
    )
  if @story.save
    redirect "/story/#{@story.id}"
  else
    slim :'/story/new', layout: :layout
  end
end


