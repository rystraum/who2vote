class CreateStances < ActiveRecord::Migration
  def change
    create_table :stances do |t|
      t.references :politician
      t.references :issue
      t.integer :stance

      t.timestamps
    end
    add_index :stances, :politician_id
    add_index :stances, :issue_id
  end
end
