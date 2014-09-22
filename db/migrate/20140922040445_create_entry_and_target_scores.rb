class CreateEntryAndTargetScores < ActiveRecord::Migration
  def change
    create_table :entry_and_target_scores do |t|
      t.integer :student_id
      t.integer :training_class_id  #暂时未用
      t.integer  "final_score"
      t.integer  "course_a_score"
      t.integer  "course_b_score"
      t.integer  "course_c_score"
      t.integer  "course_d_score"
      t.string :exam_type  #SAT /TOEFL
      t.string :score_type #入口成绩 /月份期望成绩/最终期望成绩
      t.string :expect_month #目标月份,若是最终期望成绩,则为空

      t.timestamps
    end
  end
end
