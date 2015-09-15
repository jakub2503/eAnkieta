class SurveysController < ApplicationController
  before_action :set_survey, only: [:show, :edit, :update, :destroy]

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
    @survey = Survey.new
  end

  # GET /surveys/1/edit
  def edit
  end

  # POST /surveys
  # POST /surveys.json
  def create
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

      if @survey.save
        a=a+1
        @token.destroy
      end

    end

    respond_to do |format|
      if a==num_sur and a!=0
        format.html { redirect_to surveys_url, notice: 'Poprawnie utworzono ankiety.' }
      else
        format.html { render :new }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /surveys/1
  # PATCH/PUT /surveys/1.json
  def update
    respond_to do |format|
      if @survey.update(survey_params)
        format.html { redirect_to @survey, notice: 'Survey was successfully updated.' }
        format.json { render :show, status: :ok, location: @survey }
      else
        format.html { render :edit }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /surveys/1
  # DELETE /surveys/1.json
  def destroy
    @survey.destroy
    respond_to do |format|
      format.html { redirect_to surveys_url, notice: 'Survey was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_survey
      @survey = Survey.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def survey_params
      params.require(:survey).permit(:start_date, :end_date, :interval, :start_time, :number_of_surveys)
    end
end
