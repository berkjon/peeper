helpers do

  def current_user
    session[:user_id] ? User.find(id=session[:user_id]) : nil
  end

end

