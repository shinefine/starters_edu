class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception



  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id])
  end

  def set_training_class
    @training_class =  TrainingClass.find(params[:training_class_id])
  end

end
