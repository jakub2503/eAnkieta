class LecturesController < ApplicationController
	
	layout :define_layout

	def index
		@all_lectures = Lecture.all
	end


	def statistics
		@all_lectures = Lecture.all
	end

	
	def new
		@lecture = Lecture.new
	end
	
	def edit
		@lecture = Lecture.find(params[:id])
	end
	
	def update
		@lecture = Lecture.find(params[:id])
		if @lecture.update(lecture_params)
			redirect_to all_lectures_path
		else
			render 'edit'
		end
	end
	
	def create
		@lecture = Lecture.new(lecture_params)
		if @lecture.save
			redirect_to all_lectures_path
		else
			render 'new'
		end
	end
	
	def show
		@lecture = Lecture.find(params[:id])
	end
	
	def destroy
		@lecture = Lecture.find(params[:id])
		@lecture.destroy
		
		redirect_to all_lectures_path
	end
	
	private
	def lecture_params
		params.require(:lecture).permit(:name,:year,:semester)
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