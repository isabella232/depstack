class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :setup_votes
  around_filter :back_rescue

  layout 'lumen'

  include SessionsHelper

  protected
  def authenticate_user!
    return true if logged_in?
    redirect_to :back, flash: { error: 'To up-vote, you first need to sign in!' }
    return false
  end

  def setup_votes
    @votes = logged_in? ? current_user.votes.map(&:library_id) : []
  end

  def back_rescue
    begin
      yield
    rescue ActionController::RedirectBackError
      redirect_to root_path
    end
  end
end
