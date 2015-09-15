class SurveyStatisticsSummary < ActiveRecord::Base
self.primary_key = "lecture_id"

belongs_to :lecture
end
