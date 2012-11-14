class Stance < ActiveRecord::Base
  belongs_to :politician
  belongs_to :issue
  attr_accessible :stance
end
