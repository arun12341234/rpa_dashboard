# helpers.rb
helpers do
  def logged_in?
    !session[:user_id].nil?
  end

  def redirect_if_not_logged_in
    puts session[:user_id]
    redirect '/login' unless logged_in?
  end
end
