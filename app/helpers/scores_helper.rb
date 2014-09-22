module ScoresHelper

  def can_view_subject(subject_name,training_class,user)
    #判断某个用户是否有权限看到某科目的(成绩,作业等)信息
    return true unless user.teacher?

    return user.teacher.subjects.where(training_class_id: training_class.id).any? do |subject|
       subject.name ==subject_name
    end
  end

  def scores_objects_for_nvd3_chart(student,z_training_class)
    objs =[]

    scores= student.scores.joins(:examination).where(examinations:{training_class_id:z_training_class})
    scores_count =scores.count

    if @training_class.exam_type =='SAT'
      cr_scores = []
      math_scores = []
      writing_scores = []
      #插入入口成绩
      entry_score = student.entry_and_target_scores.where(exam_type:'SAT',score_type:'入口成绩').first
      unless entry_score.nil?
        cr_scores<<{x:'入口成绩',y:entry_score.course_a_score}
        math_scores<<{x:'入口成绩',y:entry_score.course_b_score}
        writing_scores<<{x:'入口成绩',y:entry_score.course_c_score}

      end

      entry_score = student.entry_and_target_scores.where(exam_type:'SAT',score_type:'最终期望成绩').first
      unless entry_score.nil?
        cr_scores<<{x:'最终期望成绩',y:entry_score.course_a_score}
        math_scores<<{x:'最终期望成绩',y:entry_score.course_b_score}
        writing_scores<<{x:'最终期望成绩',y:entry_score.course_c_score}

      end
      #插入目标成绩 理想目标和某月目标的值
      #...
      #...

      fix_num = cr_scores.count #fix_num值为入口成绩和目标成绩的数量

      #插入模考成绩
      scores.each_with_index do |score,i |
        cr_scores<<  {x:"模考#{i + 1 }",y: score.course_a_score}
        math_scores<<  {x:"模考#{i + 1}",y: score.course_b_score}
        writing_scores<<  {x:"模考#{i + 1}",y: score.course_c_score}
      end



      num = 15-(scores_count+fix_num)
      if num>0
        num.times{|i|
        cr_scores<<{x:"模考#{scores_count + 1 + i }",y:0}
        math_scores<<{x:"模考#{scores_count + 1 + i }",y:0}
        writing_scores<<{x:"模考#{scores_count + 1 + i }",y:0}
        }
      end

      objs=[{key:'语法',values:cr_scores},{key:'数学',values:math_scores},{key:'作文',values:writing_scores}]



    elsif @training_class.exam_type =='TOEFL'

      listen_scores = []
      talk_scores = []
      read_scores = []
      writing_scores=[]

      entry_score = student.entry_and_target_scores.where(exam_type:'TOEFL',score_type:'入口成绩').first
      unless entry_score.nil?
        listen_scores<<{x:'入口成绩',y:entry_score.course_a_score}
        talk_scores<<{x:'入口成绩',y:entry_score.course_b_score}
        read_scores<<{x:'入口成绩',y:entry_score.course_c_score}
        writing_scores<<{x:'入口成绩',y:entry_score.course_d_score}
      end
      #插入入口成绩
      entry_score = student.entry_and_target_scores.where(exam_type:'TOEFL',score_type:'最终期望成绩').first
      unless entry_score.nil?
        cr_scores<<{x:'最终期望成绩',y:entry_score.course_a_score}
        math_scores<<{x:'最终期望成绩',y:entry_score.course_b_score}
        writing_scores<<{x:'最终期望成绩',y:entry_score.course_c_score}

      end

      #插入目标成绩 理想目标和某月目标的值
      #...
      #...

      fix_num = cr_scores.count #fix_num值为入口成绩和目标成绩的数量

      #插入模考成绩
      scores.each_with_index do |score,i |
        listen_scores<<  {x:"模考#{i + 1 }",y: score.course_a_score}
        talk_scores<<  {x:"模考#{i + 1}",y: score.course_b_score}

        read_scores<<  {x:"模考#{i + 1}",y: score.course_c_score}
        writing_scores<<  {x:"模考#{i + 1}",y: score.course_d_score}
      end


      num = 15-(scores_count+fix_num)
      if num>0
        num.times{|i|
          listen_scores<<{x:"模考#{scores_count + 1 + i }",y:0}
          talk_scores<<{x:"模考#{scores_count + 1 + i }",y:0}
          read_scores<<{x:"模考#{scores_count + 1 + i }",y:0}
          writing_scores<<{x:"模考#{scores_count + 1 + i }",y:0}
        }
      end

      objs=[{key:'听力',values:listen_scores},{key:'口语',values:talk_scores},{key:'阅读',values:read_scores},{key:'写作',values:writing_scores}]
    end
    return objs
  end

end
