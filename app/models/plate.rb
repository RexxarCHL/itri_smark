class Plate < ActiveRecord::Base
	has_one :user
	validates :plateNo, uniqueness: true
	before_save { self.plateNo.upcase! }
end
