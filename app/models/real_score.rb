class RealScore < ActiveRecord::Base
  belongs_to :student


  scope :entry_and_target_and_month_target, ->{where(score_type:['月份目标成绩','入口成绩','最终期望成绩'])}
  scope :entry_and_target, ->{where(score_type:['入口成绩','最终期望成绩'])}
  scope :entry, ->{where(score_type:'入口成绩')}
  scope :target, ->{where(score_type:'最终期望成绩')}
  scope :month_target, ->{where(score_type:'月份目标成绩')}
  scope :true_real, ->{where(score_type:'真实考试成绩')}
  scope :sat,->{where(exam_type: 'SAT')}
  scope :toefl,->{where(exam_type: 'TOEFL')}


  def sat_cr_score
    course_a_score || 0
  end

  def sat_math_score
    course_b_score || 0
  end

  def sat_writing_score
    course_c_score || 0
  end

  def sat_essay_score
    course_d_score || 0
  end

  def toefl_listening_score
    course_a_score || 0
  end
  def toefl_speaking_score
    course_b_score || 0
  end
  def toefl_reading_score
    course_c_score || 0
  end
  def toefl_writing_score
    course_d_score || 0
  end

end


