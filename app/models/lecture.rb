class Lecture < ActiveRecord::Base
	has_many :surveys, dependent: :destroy
	validates :name, :year, presence: true
	validates :year, numericality: {only_integer: true, :greater_than_or_equal_to => Time.now.year}
end
