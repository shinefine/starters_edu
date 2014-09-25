class Removefield < ActiveRecord::Migration
  def change
    remove_column :training_classes,:code,:string
    remove_column :training_classes,:text_book_id,:integer

  end
end
