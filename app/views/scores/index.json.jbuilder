json.array!(@scores) do |score|
  json.extract! score, :id, :id_survey, :general_score, :tempo_score, :importance_score, :comment
  json.url score_url(score, format: :json)
end
