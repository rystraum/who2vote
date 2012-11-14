class Politician < ActiveRecord::Base
  has_many :stances
  has_many :issues, through: :stances
  attr_accessible :description, :image_url, :name
  default_scope includes(:stances, :issues)
end
