=begin
get '/stylesheets/style.css' do
  scss :styles
end
=end


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

  def login_karma
    last_login = KarmaGift.where(giver_id: 4, receiver_id: session[:user_id]).last
    if last_login.nil? || last_login.created_at > (Time.now - 1.days)
      @karma_gift = KarmaGift.new(
      giver_id:    4, 
      receiver_id: session[:user_id],
      amount:      100
      )
      @karma_gift.save
    end
  end
end

get "/" do
  if session[:user_id] == nil
    @user = User.new
  else
    @current_user = User.find(session[:user_id])
  end
  @users = User.all
  @stories = Story.limit(100)
  erb :index, :layout => :'../layout'

end



post "/user_session" do

  @user = User.where(user_name: params[:user_name]).first || User.new
  if login_valid?
    session[:user_id] = @user.id
    @user.update(latitude: params[:browser_latitude], longitude: params[:browser_longitude])
    login_karma
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


get "/user/:user_name" do
  @current_user = User.find(session[:user_id])
  @user = User.where(user_name: params[:user_name]).first
  erb :'user/show', :layout => :'../layout'
end

post "/user" do
  @users= User.all
  @user = User.new(
    user_name: params[:user_name],
    password:  encrypt(params[:password]),
    name:      params[:name],
    email:     params[:email],
    latitude:  params[:browser_latitude],
    longitude: params[:browser_longitude]
    )
  if @user.save
    session[:user_id] = @user.id
    redirect request.referer
  else
    erb :index, :layout => :'../layout'
  end
end

get "/story/:id" do
  @current_user = User.find(session[:user_id])
  @user = User.new
  @users = User.all
  @stories = Story.all
  @story = Story.find(params[:id])
  @comment = Comment.new
  erb :'story/show', :layout => :'../layout'
end

post "/story" do
  @user = User.find(session[:user_id])

  @story = @user.stories.new(
    title:     params[:title],
    content:   params[:content],
    mood:      params[:mood],
    location:  params[:location],
    user_name: @user.user_name,
    latitude:  @user.latitude,
    longitude: @user.longitude
    )

  if @story.save
    redirect "/story/#{@story.id}"
  else
    # erb :'/story/new', layout: :layout
    @story.errors.full_message.join("||")
  end
end

post "/comment" do
  @story = Story.find(params[:story_id])
  @comment = @story.comments.new(
    user_id: session[:user_id],
    content: params[:content]
    )
  if @comment.save
    redirect "/story/#{@story.id}"
  else
    erb :'/story/show', :layout => :'../layout'
  end
end

post "/karmagift" do
  @amount = 100
  @user = User.find(params[:id])
  @karma_gift = KarmaGift.new(
    giver_id:    session[:user_id], 
    receiver_id: params[:id],
    amount:      @amount
    )
  if @karma_gift.save 
    redirect "/user/#{@user.user_name}?gift_success=true"
  else
    erb :'user/show', :layout => :'../layout'
  end
end



