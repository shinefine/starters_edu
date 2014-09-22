class AddDelflag < ActiveRecord::Migration
  def change
    add_column :employees,:delete_flag,:boolean,default: false
    add_column :employees,:freezing_flag,:boolean,default: false

    add_column :students,:delete_flag,:boolean,default: false
    add_column :students,:freezing_flag,:boolean,default: false

    add_column :teachers,:delete_flag,:boolean,default: false
    add_column :teachers,:freezing_flag,:boolean,default: false

  end
end


