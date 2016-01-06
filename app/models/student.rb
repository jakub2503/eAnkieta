class Student < ActiveRecord::Base
	
	attr_accessor :password
	before_save :encrypt_password
	
	validates_confirmation_of :password
	validates_presence_of :password, :on => :create
	validates_presence_of :index, :on => :create
	validates_uniqueness_of :index
	
	def self.authenticate(index, password)
		student = find_by_index(index)
		if student && student.password_hash = BCrypt::Engine.hash_secret(password,student.password_salt)
			student
		else
			nil
		end
	end
	
	def encrypt_password
		if password.present?
			self.password_salt = BCrypt::Engine.generate_salt
			self.password_hash = BCrypt::Engine.hash_secret(password,password_salt)
		end
	end
end
