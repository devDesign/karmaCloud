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
    return false if params[:password].blank?
    true if @user.password == encrypt(params[:password])
  end

  def login_karma
    superuser = User.where(user_name: 'higgs_bosun').first
    if superuser.nil?
      superuser = User.create(
        user_name: 'higgs_bosun', 
        password:   encrypt('password'),
        karma_bank: 99999
        )
    end
    superuser.update(karma_bank: 99999) if superuser.karma_bank < 1000
    last_login = KarmaGift.where(giver_id: superuser.id, receiver_id: session[:user_id]).last
    if last_login.nil? || last_login.created_at < (Time.now - 1.days)
      @karma_gift = KarmaGift.new(
      giver_id:    superuser.id, 
      receiver_id: session[:user_id],
      amount:      100
      )
      @karma_gift.save
    end
  end

  def get_top_stories
    users = User.joins(:received_karmas).where('karma_gifts.created_at > ?', Time.now - 1.day).group('users.user_name').order('sum(karma_gifts.amount) desc').limit(5)
    users.map { |u| u.stories.last }
  end
end

post "/content_demo" do
    @date = DateTime.now 
  @date = @date.strftime("%x")
  @stories = Story.all
  @story = @stories.last
  @latest_comments = []
  @latest_stories = @stories.reverse
  @latest_stories.each do |story|
    @latest_comments.push(story.comments.all)
  end
  @latest_comments = @latest_comments.reverse

  erb :demo_content
end

get "/" do
  @date = DateTime.now 
  @date = @date.strftime("%x")
  if session[:user_id] == nil
    @user = User.new
  else
    @current_user = User.find(session[:user_id])
  end
  @top_stories = get_top_stories
  @stories = Story.last(10)
  @latest_comments = []
  @latest_stories = @stories.reverse
  @latest_stories.each do |story|
    @latest_comments.push(story.comments.all)
  end
  @latest_comments = @latest_comments.reverse
  erb :index, :layout => :'../layout'

end
get "/story_feed" do
  @stories= Story.all 
  @latest_comments = []
  @latest_stories = @stories.reverse
  @latest_stories.each do |story|
    @latest_comments.push(story.comments.all)
  end
  @latest_comments = @latest_comments.reverse
 
  erb :'story_feed'
end


post "/user_session" do
  @user = User.where(user_name: params[:user_name]).first || User.new
  if login_valid?
    session[:user_id] = @user.id
    session[:current_user_name]  = @user.user_name
    session[:current_user_email] = @user.email
    @user.update(latitude: params[:browser_latitude], longitude: params[:browser_longitude])
    login_karma
    redirect request.referer
  else
    session[:login_error] = true
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
  if session[:user_id] == nil
    @current_user = User.new
  else
    @current_user = User.find(session[:user_id])
  end
  @user = User.where(user_name: params[:user_name]).first
  erb :'user/show', :layout => :'../layout'
end

post "/user" do
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
    session[:current_user_name]  = @user.user_name
    session[:current_user_email] = @user.email
    login_karma
    redirect request.referer
  else
    session[:create_user_errors]  = @user.errors.full_messages
    redirect request.referer
  end
end

get "/story/:id" do
  if session[:user_id] == nil
    @current_user = User.new
  else
    @current_user = User.find(session[:user_id])
  end
  @user = User.new
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
  @user = User.find(params[:id])
  @karma_gift = KarmaGift.new(
    giver_id:    session[:user_id], 
    receiver_id: params[:id],
    amount:      params[:karma_amount]
    )
  if @karma_gift.save 
    session[:gift_amount]  = params[:karma_amount]
    session[:gift_success] = true
    redirect "/user/#{@user.user_name}"
  else
    erb :'user/show', :layout => :'../layout'
  end
end



