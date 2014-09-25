class Addfield < ActiveRecord::Migration
  def change
    remove_column :entry_and_target_scores,:expect_month,:integer
    add_column :entry_and_target_scores,:month,:integer
    add_column :entry_and_target_scores,:year,:integer


    add_column :training_classes,:training_class_type,:string
  end
end
