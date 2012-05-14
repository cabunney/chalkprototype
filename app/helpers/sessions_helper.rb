module SessionsHelper

  def sign_in(user)
    session[:remember_token] = user.id
    #cookies[:remember_token] = user.remember_token
    current_user = user
  end

  def signed_in?
    !current_user.nil?
  end
  
  def current_user=(user)
    @current_user = user
  end

  def current_user
    if session[:remember_token]
      @current_user = User.find(session[:remember_token])
    end
  end

  def sign_out
      current_user = nil
      session.delete(:remember_token)
  end
end