get '/' do
  #check if user is logged in
  # session[:user_id] = nil
  if session[:user_id]
    @current_user = User.find(id: session[:user_id])
    erb :feed
  else
    erb :index
  end
end

post '/signup' do
  p params
  new_user = User.new(params)

  if new_user.save
    session[:user_id] = new_user.id
    redirect '/'
  else
    #show errors
    p "fix errors"
  end

end

post '/login' do
  p params
  if User.where(username: params[:username].first
    current_user = User.where(username: params[:username].first
    if current_user.password == params[:password]
      session[:user_id] = current_user.id
      redirect '/'
    else
      #show incorrect password error
      p "sorry, wrong password"
    end
  else
    #say user doesn't exist
    p "sorry, that username doesn't exist"
  end
end

get '/users' do
  @all_users = User.all

  erb :all_users
end

get '/users/:username' do
  @current_user = User.where(username: params[:username])

  erb :user_profile
end








