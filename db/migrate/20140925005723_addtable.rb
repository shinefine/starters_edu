class Addtable < ActiveRecord::Migration
  def change
    create_table 'text_books_training_classes', id: false, force: true do |t|
      t.integer  'text_book_id'
      t.integer  'training_class_id'
      t.datetime 'created_at'
      t.datetime 'updated_at'
    end
  end
end
