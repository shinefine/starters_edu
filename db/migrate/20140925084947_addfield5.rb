class Addfield5 < ActiveRecord::Migration
  def change

    add_column :homeworks,:timing_flag,:boolean,default: false

    add_column :student_attendances,:status_morning,:string
    add_column :student_attendances,:status_afternoon,:string
    add_column :student_attendances,:status_evening,:string
  end
end
