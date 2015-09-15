class Survey < ActiveRecord::Base
	attr_accessor :interval
	attr_accessor :start_time
	attr_accessor :number_of_surveys

	validates :start_date, :end_date, presence: true

	validates :interval, :start_time, presence: true
	validates :number_of_surveys, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 20 }
	validate  :start_date_end_date_correct, :dates_later_than_current, :is_valid_datetime
  	
  	def start_date_end_date_correct
    	if end_date < start_date or start_date.to_date != end_date.to_date
     		errors.add('Błędne wartości dat!')
    	end
 	end

 	def dates_later_than_current
 		if end_date < Time.now
 			errors.add('Nie można tworzyć ankiet w przeszłości!')
 		end
 	end

 	def is_valid_datetime
    	errors.add('Data nie istnieje!') if ((DateTime.parse(start_date) rescue ArgumentError) == ArgumentError or (DateTime.parse(end_date) rescue ArgumentError) == ArgumentError)
  	end



end
