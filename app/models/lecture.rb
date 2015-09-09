class Lecture < ActiveRecord::Base
	validates :name, :year, presence: true
	validates :year, numericality: {only_integer: true, :greater_than_or_equal_to => Time.now.year}
end
