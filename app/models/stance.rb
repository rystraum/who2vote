class Stance < ActiveRecord::Base
  belongs_to :politician
  belongs_to :issue
  
  attr_accessible :stance, :politician_id, :issue_id
  
  delegate :name, to: :politician, prefix: true
  delegate :name, to: :issue, prefix: true

  def pro?
    stance > 0
  end
  def anti?
    stance < 0
  end
  def neutral?
    stance == 0
  end
end
