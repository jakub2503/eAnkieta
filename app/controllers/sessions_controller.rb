class SessionsController < ApplicationController
  
  layout :define_layout
  
  def new
  end
  
  def create
	student = Student.authenticate(params[:index],params[:password])
	if student
		session[:user_id]=student.id
		redirect_to statistics_path
	else
		render "new"
	end
  end
  
  def destroy
	session[:user_id] = nil
	redirect_to log_in_path
  end
  
  private
  
  def define_layout
    # Check if logged in, because current_user could be nil.
      #if logged_in? and current_user.is_able_to('siteadmin')
        #{}"admin"
      #else
        #{}"application"
      #end
      "user"
  end
  
end
