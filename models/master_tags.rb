class MasterTag < ActiveRecord::Base
	belongs_to :group
	has_many :links
end