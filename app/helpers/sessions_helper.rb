module SessionsHelper
  def sign_in(user)
    self.current_user = user
  end

  def signed_in?
    !current_user.is_a?(Guest)
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= begin
      session[:user_id] ? User.find(session[:user_id]) : Guest.new
    end
  end

  def current_user?(user)
    user == current_user
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to '/auth/github'
    end
  end

  def redirect_back_or(default)
    redirect_to session[:return_to] || default
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end
end
