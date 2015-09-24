class SurveysController < ApplicationController
  before_action :set_survey, only: [:show, :edit, :update, :destroy]
  layout :define_layout

  # GET /lectures/surveys/1
  # GET /lectures/surveys/1.json
  def index_specific

      lectures_for_selector_s = Array.new
      lectures_temp = Lecture.all.order(updated_at: :desc)
      lectures_temp.each do |lecture|
        if lecture.score_archives_children? == false
          lectures_for_selector_s.push([lecture.name, lecture.id])
        end
      end
      flash[:lectures_for_selector_s] = lectures_for_selector_s

    lecture = Lecture.find(params[:id])
    @surveys = lecture.surveys.order(start_date: :desc)
    flash[:lecture_id_flash]= params[:id]
  end

  # POST /lectures/surveys/1
  # POST /lectures/surveys/1.json
  def index_specific_post
    redirect_to specific_surveys_path(params[:lecture_id])
  end

  # GET /statistics/1
  # GET /statistics/1.json
  def statistics_surveys
      lectures_for_selector = Array.new
      lectures_temp = Lecture.all.order(updated_at: :desc)
      lectures_temp.each do |lecture|
        if lecture.surveys_children? and lecture.number_of_votes > 0
          lectures_for_selector.push([lecture.name, lecture.id])
        end
      end
      flash[:lectures_for_selector] = lectures_for_selector
    @lecture = Lecture.find(params[:id])
    @surveys = @lecture.surveys.order(start_date: :desc)
  end

  # POST /statistics/1
  # POST /statistics/1.json
  def statistics_surveys_post
    redirect_to statistics_surveys_path(params[:lecture_id])
  end

  # GET /statistics/1/1
  # GET /statistics/1.json/1.json
  def statistics_specific
    flash.keep
    lecture = Lecture.find(params[:lecture_id_p])
      
      surveys_for_selector = Array.new
      surveys_for_selector.push(['Wszystkie', 0])
      surveys_temp = lecture.surveys.order(start_date: :desc)
      surveys_temp.each do |survey|
        if survey.children? and survey.number_of_votes > 0
          surveys_for_selector.push([survey.start_date.strftime("%d-%m-%Y"), survey.id])
        end
      end
      flash[:surveys_for_selector] = surveys_for_selector
      @survey = lecture.surveys.find(params[:survey_id_p])
  end

  # POST /statistics/1/1
  # POST /statistics/1.json/1.json
  def statistics_specific_post
    flash.keep
    if params[:lecture_id_p] != params[:lecture_id]
      redirect_to statistics_surveys_all_path(params[:lecture_id])
    else
      redirect_to statistics_specific_path(params[:lecture_id], params[:survey_id])
    end
  end

  # GET /statistics/1/0
  # GET /statistics/1.json/0.json
  def statistics_surveys_all
    flash.keep
    lecture = Lecture.find(params[:lecture_id_p])
      
      surveys_for_selector = Array.new
      surveys_for_selector.push(['Wszystkie', 0])
      surveys_temp = lecture.surveys.order(start_date: :desc)
      surveys_temp.each do |survey|
        if survey.children? and survey.number_of_votes > 0
          surveys_for_selector.push([survey.start_date.strftime("%d-%m-%Y"), survey.id])
        end
      end
      flash[:surveys_for_selector] = surveys_for_selector

      @survey = lecture.surveys.order(start_date: :desc)
  end




  # GET /surveys
  # GET /surveys.json
  def index
    @surveys = Survey.all
  end

  # GET /surveys/1
  # GET /surveys/1.json
  def show
  end

  # GET /surveys/new
  def new
    flash.keep
    @survey = Survey.new
  end

  # GET /surveys/1/edit
  def edit
    flash.keep
  end

  # POST /surveys
  # POST /surveys.json
  def create
    flash.keep
    num_sur = survey_params[:number_of_surveys].to_i
    a=0

    # create number_of_surveys surveys
    for i in 0..num_sur-1
      @survey = Survey.new(survey_params)
      # set correct date
      @survey.start_date=@survey.start_date+(i*@survey.interval.to_i*7).days
      @survey.end_date=@survey.end_date+(i*@survey.interval.to_i*7).days

      # get token from database
      @token=Token.order("RANDOM()").first
      @survey.token=@token.token

      # if save is successful - delete token from databse
      if @survey.save
        a=a+1
        @token.destroy
      else
        break;
      end

    end

    respond_to do |format|
      if a==num_sur and a!=0
        format.html { redirect_to specific_surveys_path(:id => @survey.lecture_id), notice: 'Poprawnie utworzono ankiety.' }
      elsif a>0
        format.html { redirect_to specific_surveys_path(:id => @survey.lecture_id), notice: "Poprawnie utworzono: #{a}  ankiet." }
      else
        format.html { render :new }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /surveys/1
  # PATCH/PUT /surveys/1.json
  def update
    flash.keep
    if @survey.children? == false
      respond_to do |format|
        if @survey.update(survey_params)
          format.html { redirect_to specific_surveys_path(:id => @survey.lecture_id), notice: 'Poprawnie uaktualniono ankietę.' }
        else
          format.html { render :edit }
          format.json { render json: @survey.errors, status: :unprocessable_entity }
        end
      end
    else
      format.html { redirect_to specific_surveys_path(:id => @survey.lecture_id), notice: 'Na ankietę już głosowano! Nie można jej edytować.' }
    end
  end

  # DELETE /surveys/1
  # DELETE /surveys/1.json
  def destroy
    # if survey has no children (no student voted in the survey) proceed with destroy
    if @survey.children? == false
      @survey.destroy
      respond_to do |format|
        format.html { redirect_to specific_surveys_path(:id => @survey.lecture_id), notice: 'Poprawnie usunięto ankietę.' }
      end
    else
    #if survey has children - do not destroy it and notify the user
      respond_to do |format|
        format.html { redirect_to specific_surveys_path(:id => @survey.lecture_id), notice: 'Na ankietę już głosowano! Nie można jej usunąć.' }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_survey
      @survey = Survey.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def survey_params
      params.require(:survey).permit(:start_date, :end_date, :interval, :number_of_surveys, :lecture_id)
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
