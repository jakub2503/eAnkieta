class ScoresController < ApplicationController
  before_action :set_score, only: [:show, :update, :destroy]
 
  # GET /scores
  # GET /scores.json
  def index
    @scores = Score.all
	@surveys = Survey.all
	render :layout => false
  end
  


  # GET /scores/new
  def new
    @score = Score.new
  end

    # POST /scores/new
  def new_post
	
	if  Survey.exists?(token: params[:survey][:token]) == true
		params[:temp_s] = Survey.find_by "token = '"+params[:survey][:token]+"'"
		if Time.now >= params[:temp_s][:start_date] and Time.now <= params[:temp_s][:end_date]
			@survey_id = params[:temp_s][:id]
			@score = Score.new
			params[:temp_l]= Lecture.find(params[:temp_s][:lecture_id])
			@lecture_name = params[:temp_l][:name] + " " + params[:temp_l][:year].to_s
			render :layout => false
		else		
			redirect_to scores_path(:me => 'Nie znaleziono ankiety!')
		end
	else
		
		redirect_to scores_path(:me => 'Nie znaleziono ankiety!')
	end
  end



  # POST /scores
  # POST /scores.json
  def create
    @score = Score.new(score_params)
    respond_to do |format|
      if @score.save
	    
        format.html { redirect_to scores_path(:ms => 'Dziękujemy za ocenę!') }
        format.json { render :show, status: :created, location: @score }
      else
        format.html { render :new }
        format.json { render json: @score.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scores/1
  # DELETE /scores/1.json
  def destroy
    @score.destroy
    respond_to do |format|
      format.html { redirect_to scores_path, notice: 'Score was successfully destroyed.' }
      format.json { render :index, status: :destroyed, location: @score }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
	
    def set_score
      @score = Score.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def score_params
      params.require(:score).permit(:id_survey, :general_score, :tempo_score, :importance_score, :comment)
    end
end
