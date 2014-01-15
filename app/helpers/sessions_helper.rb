module SessionsHelper

  def sign_in(user)
    remember_token = User.new_remember_token #create a new token
    cookies.permanent[:remember_token] = remember_token # place unencrypted into brower cookies
    #update_attributes allows database change without validations (pass + user)
    user.update_attribute(:remember_token, User.encrypt(remember_token)) # save encrypted into database
    self.current_user = user #set curent user equal to given user. (Incase sign in without redirect)
  end
  def current_user=(user)
  	@current_user = user
  end
  def current_user
  	remember_token = User.encrypt(cookies[:remember_token])
  	@current_user ||= User.find_by(remember_token: remember_token)
  end
  def signed_in?
  	!current_user.nil?
  end
  def sign_out
    # create new token in case of hijack
    current_user.update_attribute(:remember_token,
                                  User.encrypt(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end
end