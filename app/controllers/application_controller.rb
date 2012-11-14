class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_path, :alert => exception.message
  end
  before_filter :get_all_issues

  def get_all_issues
    @issues = Issue.all
  end
end
