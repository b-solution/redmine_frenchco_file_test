class AddProjectToTestPlans < ActiveRecord::Migration
  def change
    add_column :test_plans, :project_id, :integer

    add_index :test_plans, :project_id
  end
end
