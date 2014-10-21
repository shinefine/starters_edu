class AddFieldsForHomeworkfinished < ActiveRecord::Migration
  def change
    add_column :homework_finishes,:description,:string
    add_column :homework_finishes,:status,:string

  end
end
