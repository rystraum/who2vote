class AddIndexToStances < ActiveRecord::Migration
  def change
    add_index :stances, [:politician_id, :issue_id], unique: true
  end
end
