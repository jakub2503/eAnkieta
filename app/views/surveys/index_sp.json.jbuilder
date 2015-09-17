json.array!(@surveys) do |survey|
  json.extract! survey, :id, :token, :start_date, :end_date
  json.url survey_url(survey, format: :json)
end
