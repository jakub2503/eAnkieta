class Survey < ActiveRecord::Base
	has_many :scores
	belongs_to :lecture
	attr_accessor :interval
	attr_accessor :number_of_surveys

	validates :start_date, :end_date, presence: true

	validates :interval, presence: true, :on => :create
	validates :number_of_surveys, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 20 }, :on => :create
	validate  :start_date_before_end_date,:start_date_end_date_same_day, :dates_later_than_current, :is_valid_datetime
  	
  	def average_general_score
  		scores.average(:general_score)
  	end
  	def average_tempo_score
  		scores.average(:tempo_score)
  	end
  	def average_importance_score
  		scores.average(:importance_score)
  	end
  	def number_of_comments
  		#scores.where("COALESCE(comment,'') = ?", '').count
  		scores.where("comment != ?",'').count
  	end
  	def number_of_votes
  		scores.count
  	end

	def children?
    	scores.any?
  	end

  def start_date_before_end_date
    	if end_date <= start_date
     		errors.add(:base, 'Godzina rozpoczęcia ankiety musi być wcześniejsza niż jej zakończenia!')
    	end
 	end

  def start_date_end_date_same_day
      if start_date.to_date != end_date.to_date
        errors.add(:base, 'Ankieta musi się rozpoczynać i kończyć w tym samym dniu!')
      end
  end

 	def dates_later_than_current
 		if start_date < Time.now
 			errors.add(:base, 'Nie można tworzyć ankiet w przeszłości!')
 		end
 	end

 	def is_valid_datetime
    	errors.add(:base ,'Data nie istnieje!') if (Date.valid_date?(start_date.year,start_date.month,start_date.mday) == false)
  end



end
