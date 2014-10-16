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




  attr_accessor :cache_real_scores,
                :score_trend_sat_total,
                :score_trend_sat_reading,
                :score_trend_sat_math,
                :score_trend_sat_grammar,
                :score_trend_sat_writing,
                :max_real_score_sat_total,
                :max_real_score_sat_reading,
                :max_real_score_sat_math,
                :max_real_score_sat_grammar,
                :max_real_score_sat_writing





  def calculate_sat_scores_trend()
                  #统计分数趋势

                  subject_scores = cache_real_scores.map{|r|r.final_score}

                  subject_max_score =subject_scores.max||0
                  subject_min_score =subject_scores.min||0
                  @score_trend_sat_total = subject_max_score - subject_min_score
                  @max_real_score_sat_total =subject_max_score


                  subject_scores = cache_real_scores.map{|r|r.course_a_score}

                  subject_max_score =subject_scores.max||0
                  subject_min_score =subject_scores.min||0
                  @score_trend_sat_reading = subject_max_score - subject_min_score
                  @max_real_score_sat_reading =subject_max_score

                  subject_scores = cache_real_scores.map{|r|r.course_b_score}

                  subject_max_score =subject_scores.max||0
                  subject_min_score =subject_scores.min||0
                  @score_trend_sat_math = subject_max_score - subject_min_score
                  @max_real_score_sat_math =subject_max_score

                  subject_scores = cache_real_scores.map{|r|r.course_c_score}

                  subject_max_score =subject_scores.max||0
                  subject_min_score =subject_scores.min||0

                  @score_trend_sat_grammar = subject_max_score - subject_min_score
                  @max_real_score_sat_grammar =subject_max_score

                  subject_scores = cache_real_scores.map{|r|r.course_d_score}

                  subject_max_score =subject_scores.max||0
                  subject_min_score =subject_scores.min||0

                  @score_trend_sat_writing = subject_max_score - subject_min_score
                  @max_real_score_sat_writing =subject_max_score

  end
  def summary_sat_scores_max(subject)
    max =0
    if subject =='总分'
      max = @max_real_score_sat_total
      if(max>2300)
        return '2300分以上'
      end
      if(max>2200)
        return '2200分~2300分'
      end
      if(max>2100)
        return '2100分~2200分'
      end
      if(max>2000)
        return '2000分~2100分'
      end
      if(max>1900)
        return '1900分~2000分'
      end
      return '1900分以下'
    end



    case subject
      when 'Reading'
        max = @max_real_score_sat_reading
      when 'Math'
        max = @max_real_score_sat_math
      when 'Grammar'
        max = @max_real_score_sat_grammar
      when 'Writing'
        max = @max_real_score_sat_writing
    end

    if(max>700)
      return '700分以上'
    end

    if(max>650)
      return '650分~700分'
    end

    if(max>600)
      return '600分~650分'
    end

    if(max>550)
      return '550分~600分'
    end
    if(max>500)
      return '500分~550分'
    end
    if(max>450)
      return '450分~500分'
    end
    if(max>400)
      return '400分~450分'
    end


    return '400分以下'
  end
  def summary_sat_scores_trend(subject)
    trend =0
    case subject
      when '总分'
        trend = @score_trend_sat_total
      when 'Reading'
        trend = @score_trend_sat_reading
      when 'Math'
        trend = @score_trend_sat_math
      when 'Grammar'
        trend = @score_trend_sat_grammar
      when 'Writing'
        trend = @score_trend_sat_writing
    end

    if(trend>200)
      return '200分以上'
    end

    if(trend>150)
      return '150分~200分'
    end

    if(trend>100)
      return '100分~150分'
    end

    if(trend>50)
      return '50分~100分'
    end


    return '0分~50分'
  end

  def name
    self.user.name
  end


  def summary_training_class_names_list
    #生成一段文字描述,用于表示学员参加过那些培训班(显示培训班的阶段名,而非培训班级名)
    training_classes.map{|tc| "#{tc.training_class_type}(#{tc.name})"}.join("")
    tc_type_names=training_classes.map{|tc| tc.training_class_type}


    summary_toefl = TrainingClassType.toefl_types.map{|toefl_type|
      if tc_type_names.count(toefl_type) > 0
        '<i class="green checkmark icon"></i><label class="ui green label">' +
            toefl_type +
        '</label>'
      else
        toefl_type
      end

    }.join("<br>")


    summary_sat = TrainingClassType.sat_types.map{|sat_type|

      if tc_type_names.count(sat_type) > 0

        '<i class="green checkmark icon"></i><label class="ui green label">' + sat_type +
        '</label>'
      else

        sat_type

      end


    }.join("<br>")

     summary_toefl +"<br>"+ summary_sat
  end

  def month_target_scores
    real_scores.month_target
  end

  def sat_month_target_scores
    real_scores.sat.month_target
  end

  def toefl_month_target_scores
    real_scores.toefl.month_target
  end

  def entry_and_target_scores
    real_scores.entry_and_target
  end

  def summary_attendance_text(training_class)
    return training_class.student_attendance_summary(self)
  end
  def summary_dictation_text(training_class)
    return training_class.student_dictation_summary(self)
  end

  def dictation_score_pass?(score,pass_line)
    #计算某次听写成绩是否及格
    if score && pass_line
        return score < pass_line
    end
    return false
  end
end
