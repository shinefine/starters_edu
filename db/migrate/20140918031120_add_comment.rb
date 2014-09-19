class AddComment < ActiveRecord::Migration
  def change
    create_table 'comments' do |t|
      t.integer 'teacher_id'
      t.integer 'training_class_id'
      t.integer 'student_id'
      t.string  'text'
      t.date    'comment_date'
      t.datetime 'created_at'
      t.datetime 'updated_at'
    end
  end
end
