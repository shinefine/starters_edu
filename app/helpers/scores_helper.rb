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
      grammar_scores = []
      #插入入口成绩
      real_score = student.real_scores.sat.entry.first
      unless real_score.nil?
        total_score = real_score.course_a_score + real_score.course_b_score+ real_score.course_c_score
        cr_scores<<{x:"入口成绩(#{total_score})",y:real_score.course_a_score}
        math_scores<<{x:"入口成绩(#{total_score})",y:real_score.course_b_score}
        grammar_scores<<{x:"入口成绩(#{total_score})",y:real_score.course_c_score}

      end

      real_score = student.real_scores.sat.target.first
      unless real_score.nil?

        total_score = real_score.course_a_score + real_score.course_b_score+ real_score.course_c_score


        cr_scores<<{x:"最终期望成绩(#{total_score})",y:real_score.course_a_score}
        math_scores<<{x:"最终期望成绩(#{total_score})",y:real_score.course_b_score}
        grammar_scores<<{x:"最终期望成绩(#{total_score})",y:real_score.course_c_score}

      end
      #插入目标成绩 理想目标和某月目标的值
      #...
      #...

      fix_num = cr_scores.count #fix_num值为入口成绩和目标成绩的数量

      #插入模考成绩
      scores.each_with_index do |score,i |
        total_score = score.course_a_score + score.course_b_score+ score.course_c_score


        cr_scores<<  {x:"模考#{i + 1 }(#{total_score})",y: score.course_a_score}
        math_scores<<  {x:"模考#{i + 1}(#{total_score})",y: score.course_b_score}
        grammar_scores<<  {x:"模考#{i + 1}(#{total_score})",y: score.course_c_score}
      end



      #插入更多未考的模考成绩
      num = 15-(scores_count+fix_num)
      if num>0
        num.times{|i|
        cr_scores<<{x:"模考#{scores_count + 1 + i }",y:0}
        math_scores<<{x:"模考#{scores_count + 1 + i }",y:0}
        grammar_scores<<{x:"模考#{scores_count + 1 + i }",y:0}
        }
      end

      objs=[{key:'阅读',values:cr_scores},{key:'数学',values:math_scores},{key:'语法',values:grammar_scores}]



    elsif @training_class.exam_type =='TOEFL'

      listen_scores = []
      talk_scores = []
      read_scores = []
      writing_scores=[]

      real_score = student.real_scores.toefl.entry.first
      unless real_score.nil?
        listen_scores<<{x:'入口成绩',y:real_score.course_a_score}
        talk_scores<<{x:'入口成绩',y:real_score.course_b_score}
        read_scores<<{x:'入口成绩',y:real_score.course_c_score}
        writing_scores<<{x:'入口成绩',y:real_score.course_d_score}
      end
      #插入入口成绩
      real_score = student.real_scores.toefl.target.first
      unless real_score.nil?
        listen_scores<<{x:'最终期望成绩',y:real_score.course_a_score}
        talk_scores<<{x:'最终期望成绩',y:real_score.course_b_score}
        read_scores<<{x:'最终期望成绩',y:real_score.course_c_score}
        writing_scores<<{x:'最终期望成绩',y:real_score.course_d_score}

      end

      #插入目标成绩 理想目标和某月目标的值
      #...
      #...

      fix_num = listen_scores.count #fix_num值为入口成绩和目标成绩的数量

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
