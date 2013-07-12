require 'bcrypt'

class User < ActiveRecord::Base
	validates :username, uniqueness: true
	validates :passwd, presence: true

	before_save { self.username.downcase! }

	include BCrypt

	def password
		@password ||= Password.new(passwd)
	end

	def password=(new_password)
		if /\A[A-Za-z0-9]+\z/ === new_password
			@password = Password.create(new_password)
			self.passwd = @password
		end
	end

	def authenticate(attempt_password)
		self.password == attempt_password
	end

	def name
		@username
	end
end
