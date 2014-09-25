helpers do

  def encrypt(input)
    Digest::SHA1.hexdigest(input) unless input.blank?
  end

  def login_valid?
    return true unless @user.password != encrypt(params[:password])
  end
end

before do

end

get "/" do
  slim :index, layout: :layout
end

post "/user_session/new" do
  @user = User.where(email: params[:email]).first || User.new
  if login_valid?
    session[:user_id] = @user.id
    redirect 'request.referer'
  else
    @login_errors = true
    slim :'/', layout: :layout
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
  @user = User.find(session[:user_id])
  @story = @user.stories.new(
    title:   params[:title],
    content: params[:content],
    mood:    params[:mood]
    )
  if @story.save
    redirect "/story/#{@story.id}"
  else
    slim :'/story/new', layout: :layout
  end
end