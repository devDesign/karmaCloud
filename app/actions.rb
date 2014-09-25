helpers do

  def encrypt(input)
    Digest::SHA1.hexdigest(input) unless input.blank?
  end

  def login_valid?
    return true unless @user.password != encrypt(params[:password])
  end
end

get "/" do
  slim :index, :layout => :layout
end

post "/user_session/new" do
  @user = User.where(email: params[:email]).first || User.new
  if login_valid?
    session[:user_id] = @user.id
    redirect '/'
  else
    @login_errors = true
    slim :'/'
  end
end

delete "/user_session" do
  #logout user
end

get "/user/new" do
  @user = User.new
  slim :'/user/new', :layout => :layout
end

get "/user/:id" do
  #/user/show
  slim :user, :layout => :layout
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
    slim :'/user/new', :layout => :layout
  end
end

get "/story/new" do
  #/story/new
end

get "/story/:id" do
  #/story/show
end

post "/story" do
  #create story
end