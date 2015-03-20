get '/' do
  #check if user is logged in
  # session[:user_id] = nil
  # binding.pry
  if session[:user_id]
    erb :feed
  else
    erb :index
  end
end

post '/signup' do
  p params
  new_user = User.new(params)
  new_user.password = params[:password]
  if new_user.save
    session[:user_id] = new_user.id
    redirect '/users'
  else
    #show errors
    p "fix errors"
  end

end

post '/login' do
  p params
  current_user = User.where(username: params[:username]).first
    if current_user && current_user.password == params[:password]
      session[:user_id] = current_user.id
      redirect '/'
    else
      #show incorrect password error
      p "sorry, wrong password"
    end
end

get '/users' do
  @all_users = User.all

  erb :"discover-users"
end

get '/users/:username' do
  @current_user = User.where(username: params[:username]).first

  erb :user_profile
end

post '/users/:username/whisper' do
  current_user.whispers.create(content: params[:whisper])
  redirect "/users/#{current_user.username}"
end

put '/users/:username/unstalk' do
  user_to_unstalk = User.where(username: params[:username]).first
  current_user.unstalk(user_to_unstalk)
  redirect '/users'
end

put '/users/:username/stalk' do
  user_to_stalk = User.where(username: params[:username]).first
  current_user.stalk(user_to_stalk)
  redirect '/users'
end

get '/logout' do
  session.clear
  redirect '/'
end








