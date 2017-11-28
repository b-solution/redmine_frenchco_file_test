class AddTimestampToTestPlans < ActiveRecord::Migration
  def change
    add_column :test_plans, :created_on, :datetime
    add_column :test_plans, :updated_on, :datetime

    #fix missing project_id
    TestPlan.all.each do |tp|
      tp.project_id = tp.issue.project_id
      tp.save
    end
  end
end
