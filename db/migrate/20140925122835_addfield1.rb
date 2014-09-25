class Addfield1 < ActiveRecord::Migration
  def change
    remove_column :students,:qq_number,:string
    remove_column :students,:tinypost_number,:string
    remove_column :students,:identify_card,:string

    add_column :users,:qq_number,:string
    add_column :users,:tinypost_number,:string
    add_column :users,:identify_card,:string
  end
end
