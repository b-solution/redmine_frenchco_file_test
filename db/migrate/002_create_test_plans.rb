class CreateTestPlans < ActiveRecord::Migration
  def change
    create_table :test_plans do |t|
      t.integer :issue_id
      t.string :url
      t.text :remark
      t.integer :functional_test

      t.integer :test_in_ff
      t.integer :test_in_ie
      t.integer :test_in_ch
      t.integer :test_in_sf
      t.integer :test_in_mobile
      t.integer :test_in_real_device
      t.integer :internal_control

      t.string :client_note


    end

    add_index :test_plans, :issue_id

  end
end
