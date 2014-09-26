get '/stylesheets/style.css' do
  scss :styles
end

get '/map' do
  erb :'/map_test'
end


get "/map" do  
  erb :'map_test'
end

get '/stories.json' do
  @stories = Story.where("created_at > ?", Date.yesterday)
  json @stories
end

helpers do

  def encrypt(input)
    Digest::SHA1.hexdigest(input) unless input.blank?
  end

  def login_valid?
    return true unless @user.password != encrypt(params[:password])
  end
end


post "/user_session/new" do
  @user = User.where(user_name: params[:user_name]).first || User.new
  if login_valid?
    session[:user_id] = @user.id
    redirect request.referer
  else
    @login_errors = true
    redirect request.referer
  end
end

delete "/user_session" do
  session[:user_id] = nil
  redirect request.referer
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
    name:      params[:name],
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


