class Student < ActiveRecord::Base

  #学员可以属于多个培训班(同时培训班包含多个学员)
  has_and_belongs_to_many :training_classes

  #学员可能登录系统,所以有一个对应的账户
  belongs_to :user

  has_many :comments #学员有多条来自讲师的评语
  has_many :homework_finishs
  has_many :homeworks ,through: :homework_finishs #学员会完成讲师布置的多套作业

  has_and_belongs_to_many :test_papers  #学员做过的考题，有多套
  has_many :scores ,foreign_key: 'student_id' #各次考试成绩

  has_many :student_attendances
  has_many :dictation_scores

  #定义学员信息时的Form 能够同时定义其登录账户的信息
  accepts_nested_attributes_for :user




  def name
    self.user.name
  end

  def summary_attendance_text(training_class)
    return training_class.student_attendance_summary(self)
  end
  def summary_dictation_text(training_class)
    return training_class.student_dictation_summary(self)
  end
end
