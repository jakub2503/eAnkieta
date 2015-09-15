require 'test_helper'

class ScoresControllerTest < ActionController::TestCase
  setup do
    @score = scores(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:scores)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create score" do
    assert_difference('Score.count') do
      post :create, score: { comment: @score.comment, general_score: @score.general_score, id_survey: @score.id_survey, importance_score: @score.importance_score, tempo_score: @score.tempo_score }
    end

    assert_redirected_to score_path(assigns(:score))
  end

  test "should show score" do
    get :show, id: @score
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @score
    assert_response :success
  end

  test "should update score" do
    patch :update, id: @score, score: { comment: @score.comment, general_score: @score.general_score, id_survey: @score.id_survey, importance_score: @score.importance_score, tempo_score: @score.tempo_score }
    assert_redirected_to score_path(assigns(:score))
  end

  test "should destroy score" do
    assert_difference('Score.count', -1) do
      delete :destroy, id: @score
    end

    assert_redirected_to scores_path
  end
end
