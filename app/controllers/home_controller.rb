class HomeController < ApplicationController
  def index
    @politicians = Politician.all
  end

  def filter
    @politicians = Politician.get_by_stance get_issues_and_stances
    render "index"
  end

  def get_issues_and_stances
    issues = []
    params[:issues].each_pair do |issue_id, stances|
      stance_list = []
      stances.each_key do |key|
        stance_list << key
        instance_variable_set("@#{key}_#{issue_id}", true)
      end
      issues << { issue_id => stance_list }
    end
    issues
  end
end