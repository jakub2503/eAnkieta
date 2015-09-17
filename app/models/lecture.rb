class Lecture < ActiveRecord::Base
	has_many :surveys, dependent: :destroy
	has_many :score_archives, dependent: :destroy
	has_one :survey_statistics_summary

	delegate :average_general_score, :average_tempo_score, :average_importance_score, to: :survey_statistics_summary

	validates :name, :year, presence: true
	validates :year, numericality: {only_integer: true, :greater_than_or_equal_to => Time.now.year}

	def average_general_score
		survey_statistics_summary.general_score
	end
	def average_tempo_score
		survey_statistics_summary.tempo_score
	end
	def average_importance_score
		survey_statistics_summary.importance_score
	end
	def number_of_votes
		survey_statistics_summary.number_of_votes
	end
end
