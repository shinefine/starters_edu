class Student < ActiveRecord::Base
  has_many :real_scores
  #学员可以属于多个培训班(同时培训班包含多个学员)
  has_and_belongs_to_many :training_classes

  #学员可能登录系统,所以有一个对应的账户
  belongs_to :user

  belongs_to :creator ,class_name:Employee

  has_many :comments #学员有多条来自讲师的评语
  has_many :homework_finishs
  has_many :homeworks ,through: :homework_finishs #学员会完成讲师布置的多套作业

  has_and_belongs_to_many :test_papers  #学员做过的考题，有多套
  has_many :scores ,foreign_key: 'student_id' #各次考试成绩

  has_many :student_attendances
  has_many :dictation_scores

  #定义学员信息时的Form 能够同时定义其登录账户的信息
  accepts_nested_attributes_for :user


  accepts_nested_attributes_for :real_scores,:reject_if => lambda { |a| a[:final_score].blank? },
                                allow_destroy: true


  default_scope {where delete_flag: false}
  def name
    self.user.name
  end

  def summary_training_class_names_list
    training_classes.map{|tc| "#{tc.training_class_type}(#{tc.name})"}.join("\n")

  end

  def month_target_scores
    real_scores.where(score_type:'月份目标成绩')
  end

  def summary_attendance_text(training_class)
    return training_class.student_attendance_summary(self)
  end
  def summary_dictation_text(training_class)
    return training_class.student_dictation_summary(self)
  end
end
