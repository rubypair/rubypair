class ApplicationController < ActionController::Base
  helper_method :current_user
  helper :application
  protect_from_forgery

  private

  def current_user
    if session[:github_login]
      @current_user ||= User.where(:github_login => session[:github_login]).first
    end
  end
end
