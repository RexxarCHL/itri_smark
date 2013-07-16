require 'bcrypt'

class User < ActiveRecord::Base
	has_many :plates, dependent: :destroy

	validates :username, uniqueness: true
	validates :passwd, presence: true

	before_save { self.username.downcase! }

	alias_attribute :name, :username

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

	def new_plate
	end

	def update(params)
		self.username = params[:username] if params[:username]
		self.password = params[:passwd] unless params[:passwd].empty?
		self.save
	end

    def getPlates
      plates = self.plates
      plateNos = []
      plates.each do |p|
        plateNos << p.plateNo
      end
      plateNos
    end
end
