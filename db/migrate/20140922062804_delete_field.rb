class DeleteField < ActiveRecord::Migration
  def change
    remove_column :students,:entry_score_sat,:integer
    remove_column :students,:target_score_sat,:integer
    remove_column :students,:entry_score_toefl,:integer
    remove_column :students,:target_score_toefl,:integer

    remove_column :students,:entry_sat_cr,:integer
    remove_column :students,:entry_sat_math,:integer

    remove_column :students,:entry_sat_writing,:integer

    remove_column :students,:target_sat_cr,:integer
    remove_column :students,:target_sat_math,:integer
    remove_column :students,:target_sat_writing,:integer
    remove_column :students,:entry_toefl_reading,:integer
    remove_column :students,:entry_toefl_listen,:integer
    remove_column :students,:entry_toefl_say,:integer
    remove_column :students,:entry_toefl_writing,:integer
    remove_column :students,:target_toefl_reading,:integer
    remove_column :students,:target_toefl_listen,:integer

    remove_column :students,:target_toefl_say,:integer
    remove_column :students,:target_toefl_writing,:integer

    remove_column :students,:expect_sat_exam_month_5,:integer
    remove_column :students,:expect_sat_exam_month_6,:integer
    remove_column :students,:expect_sat_exam_month_10,:integer
    remove_column :students,:expect_sat_exam_month_11,:integer
    remove_column :students,:expect_sat_exam_month_12,:integer


  end
end
