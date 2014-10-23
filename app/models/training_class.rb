class TrainingClass < ActiveRecord::Base
  belongs_to :master_teacher, class_name: :Employee  #班主任
  has_and_belongs_to_many :text_books

  #学员可以属于多个培训班(同时培训班包含多个学员)
  has_and_belongs_to_many :students



  has_many :teachers ,through: :subjects

  has_many :examinations #一个班级能有多个模拟考试(按日期)
  has_many :dictations #一个班级能有多个听写测验(按日期)
  has_many :attendances #一个班级能有多个考勤情况(按日期)
  has_many :homeworks #班级的各个课程的讲师会布置作业。





  has_many :subjects
  accepts_nested_attributes_for :subjects  ,:reject_if => lambda { |a| a[:name].blank? },
                                allow_destroy: true

  validates :exam_type,presence: true
  validates :name,presence: true
  validates :end_date,presence: true
  validates :start_date,presence: true


  default_scope {order('start_date DESC')}

  def student_attendance(student)
    #返回指定学生的所有出勤记录(针对本培训班的)
    return student.student_attendances.where(attendance_id: self.attendance_ids )
  end


  def student_dictions(student)
    #返回指定学生的所有听写成绩(针对本培训班的)
    return student.dictation_scores.where(dictation_id: self.dictation_ids )
  end


  def student_attendance_summary(student)


    morning_grp=student_attendance(student).select{|stu_atten| not stu_atten.status_morning.blank?}.group_by{|stu_atten| stu_atten.status_morning}
    afternoon_grp=student_attendance(student).select{|stu_atten| not stu_atten.status_afternoon.blank?}.group_by{|stu_atten| stu_atten.status_afternoon}
    evening_grp=student_attendance(student).select{|stu_atten| not stu_atten.status_evening.blank?}.group_by{|stu_atten| stu_atten.status_evening}

    grp_result=Hash.new(0)

    ['出勤','迟到','早退','未出勤'].each{|key|
      grp_result[key] = (morning_grp[key].nil? ? 0 : morning_grp[key].length) +
          (afternoon_grp[key].nil? ? 0 : afternoon_grp[key].length)  +
          (evening_grp[key].nil? ? 0 : evening_grp[key].length)

    }

    col= grp_result.map{|key,value|
      "#{key} #{grp_result[key]}次 "
    }
    return col.join(',')
  end


  def student_dictation_summary(student)

    return student_dictions(student).count.to_s + "次"

  end

  def summary_text_book_names_list
    return text_books.map{|tb| tb.name}.join("\n")
  end

  def sat_cr_teachers
    self.subjects.where(name:'CR').map{|sub| sub.teacher}
  end
  def sat_math_teachers
    self.subjects.where(name:'Math').map{|sub| sub.teacher}
  end
  def sat_grammar_teachers
    self.subjects.where(name:'Grammar').map{|sub| sub.teacher}
  end
  def sat_essay_teachers
    self.subjects.where(name:'Essay').map{|sub| sub.teacher}
  end

  def toefl_read_teachers
    self.subjects.where(name:'Reading').map{|sub| sub.teacher}
  end
  def toefl_listen_teachers
    self.subjects.where(name:'Listening').map{|sub| sub.teacher}
  end
  def toefl_write_teachers
    self.subjects.where(name:'Writing').map{|sub| sub.teacher}
  end
  def toefl_talk_teachers
    self.subjects.where(name:'Speaking').map{|sub| sub.teacher}
  end


end
