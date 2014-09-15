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





end
