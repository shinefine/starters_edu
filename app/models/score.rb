class Score < ActiveRecord::Base
#模拟考试得分
  belongs_to :examination  #属于某次模拟考试
  belongs_to :student    #属于某个学员类型的user
  has_many :score_details  #明细记录了每道题的对错情况

  accepts_nested_attributes_for :score_details  ,
                                allow_destroy: true


  @questions_group_by_section= Hash.new {|hash, key| hash[key] = []}
  def questions_GroupBySection
    @questions_group_by_section
  end


#表字段和考试科目成绩对应关系

# -----SAT-------------
#  CR总分--> :course_a_score

  #  raw score (CR)-->   :stat_07

  #       CR 词汇 : 正确数量-->:stat_01 ,错误数量-->:stat_02 ,空题数量--> :stat_03
  #       CR 阅读 : 正确数量-->:stat_04 ,错误数量-->:stat_05 ,空题数量--> :stat_06

#  数学得分--> :course_b_score

  #  raw score(math)-->  :stat_11

  #       正确数量-->:stat_08 ,错误数量--> :stat_09 ,空题数量-->:stat_10

#  写作得分--> :course_c_score

  #  raw score(write)-->  :stat_15
  #
  #      正确数量--> :stat_12 ,错误数量--> :stat_13, 空题数量-->:stat_14

  #       写作 作文子项--> :stat_16

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
