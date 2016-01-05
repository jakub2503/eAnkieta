class StudentsController < ApplicationController
  
  layout :define_layout

  def new
	@student = Student.new
  end
  
  def create
  @student = Student.new(student_params)
	if @student.save
		redirect_to root_url, :notice => "Signed up!"
	else
		render "new"
	end
  end
  
  private
  def student_params
	params.require(:student).permit(:index, :password)
  end
  
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
