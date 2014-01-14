class Link < ActiveRecord::Base
	belongs_to :group
	has_many :link_tags
	has_many :incomings
end