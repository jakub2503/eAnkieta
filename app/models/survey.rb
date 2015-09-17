class Survey < ActiveRecord::Base
	has_many :scores
	belongs_to :lecture
	attr_accessor :interval
	attr_accessor :number_of_surveys

	validates :start_date, :end_date, presence: true

	validates :interval, presence: true
	validates :number_of_surveys, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 20 }
	validate  :start_date_end_date_correct, :dates_later_than_current
  	

	def children?
    	scores.any?
  	end

  	def start_date_end_date_correct
    	if end_date < start_date or start_date.to_date != end_date.to_date
     		errors.add(:base, 'Błędne wartości dat!')
    	end
 	end

 	def dates_later_than_current
 		if end_date < Time.now
 			errors.add(:base, 'Nie można tworzyć ankiet w przeszłości!')
 		end
 	end

 	def is_valid_datetime
    	errors.add(:base ,'Data nie istnieje!') if ((DateTime.parse(start_date) rescue ArgumentError) == ArgumentError or (DateTime.parse(end_date) rescue ArgumentError) == ArgumentError)
  	end



end
