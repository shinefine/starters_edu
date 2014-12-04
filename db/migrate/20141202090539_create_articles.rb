class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :Title
      t.string :Content

      t.timestamps
    end
  end
end
