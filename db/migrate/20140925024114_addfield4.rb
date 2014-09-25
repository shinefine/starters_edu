class Addfield4 < ActiveRecord::Migration
  def change
    remove_column :training_classes,:training_class_type,:integer
    add_column :training_classes,:training_class_type,:string
  end
end
