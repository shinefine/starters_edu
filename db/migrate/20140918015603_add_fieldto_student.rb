class AddFieldtoStudent < ActiveRecord::Migration
  def change
    add_column :students,:birth_day,:date
    add_column :students,:parent2_name,:string
    add_column :students,:parent2_tel,:string

  end
end
