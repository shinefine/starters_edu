class Teacher < ActiveRecord::Base
  #讲师可以教多门科目课程从而属于多个培训班(同时培训班包含多个讲师)
  has_many :subjects
  has_many :training_classes ,through: :subjects


  has_many :homeworks  #讲师会布置多套作业，学员会完成多套作业


  #讲师可能登录系统,所以有一个对应的账户
  belongs_to :user

  #定义讲师信息时的Form 能够同时定义其登录账户的信息
  accepts_nested_attributes_for :user
  default_scope {where delete_flag: false}


  def name
    self.user.name
  end

  def is_SAT_CR_teacher?(training_class)
    return training_class.sat_cr_teachers.any?{|teacher| teacher.id == self.id}
  end

  def is_SAT_Math_teacher?(training_class)
    return training_class.sat_math_teachers.any?{|teacher| teacher.id == self.id}
  end

  def is_SAT_Grammar_teacher?(training_class)
    return training_class.sat_grammar_teachers.any?{|teacher| teacher.id == self.id}
  end

  def is_SAT_Essay_teacher?(training_class)
    return training_class.sat_essay_teachers.any?{|teacher| teacher.id == self.id}
  end

  def is_TOEFL_READ_teacher?(training_class)
    return training_class.toefl_read_teachers.any?{|teacher| teacher.id == self.id}
  end

  def is_TOEFL_LISTEN_teacher?(training_class)
    return training_class.toefl_listen_teachers.any?{|teacher| teacher.id == self.id}
  end

  def is_TOEFL_TALK_teacher?(training_class)
    return training_class.toefl_talk_teachers.any?{|teacher| teacher.id == self.id}
  end

  def is_TOEFL_WRITE_teacher?(training_class)
    return training_class.toefl_write_teachers.any?{|teacher| teacher.id == self.id}
  end

end