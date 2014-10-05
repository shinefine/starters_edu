class Changename < ActiveRecord::Migration
  def change
    rename_table :entry_and_target_scores,:real_scores

  end
end
