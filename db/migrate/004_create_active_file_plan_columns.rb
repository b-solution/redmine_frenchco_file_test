class CreateActiveFilePlanColumns < ActiveRecord::Migration
  def change
    create_table :active_file_plan_columns do |t|

      t.integer :project_id

      t.string :column_name

      t.boolean :is_active


    end

    add_index :active_file_plan_columns, :project_id

    add_column :test_plans, :raspberry, :integer
    add_column :test_plans, :thomson, :integer
    add_column :test_plans, :vega, :integer
    add_column :test_plans, :android, :integer
    add_column :test_plans, :ready_for_demo, :integer
  end
end
