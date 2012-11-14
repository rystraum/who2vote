class Politician < ActiveRecord::Base
  has_many :stances
  has_many :issues, through: :stances
  attr_accessible :description, :image_url, :name
  default_scope includes(:stances, :issues)
  
  class << self
    def get_by_stance(issues)
      politicians = []
      issues.each do |issue|
        issue.each_pair do |issue_id, stances|
          stances.each do |stance|
            stancev = case stance
                      when "pro"
                        1
                      when "anti"
                        -1
                      else
                        0
                      end
            
            politicians << Stance.where(issue_id: issue_id, stance: stancev).to_a
          end
        end
      end
      politicians.flatten.collect(&:politician).uniq
    end
  end
end
