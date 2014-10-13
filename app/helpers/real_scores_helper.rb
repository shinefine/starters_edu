module RealScoresHelper

  def seek_sat_scores(real_scores,month,subject)
    #从一些列real_Scores 记录(SAT)中找出指定月份的记录(只找出一条),然后返回其对应的科目分数
    v = real_scores.find{|record| record.month==month}

    return "" if v.nil?

    case subject
      when '总分'
        return v.final_score
      when 'Reading'
        return v.course_a_score
      when 'Math'
        return v.course_b_score
      when 'Grammar'
        return v.course_c_score
      when 'Writing'
        return v.course_d_score
    end
    return "--"
  end

  def summary_scores_trend(real_scores,subject)
    #统计分数趋势
    subject_scores=[0]
    case subject
      when '总分'
        subject_scores = real_scores.map{|r|r.final_score}

      when 'Reading'
        subject_scores = real_scores.map{|r|r.course_a_score}
      when 'Math'
        subject_scores = real_scores.map{|r|r.course_b_score}
      when 'Grammar'
        subject_scores = real_scores.map{|r|r.course_c_score}
      when 'Writing'
        subject_scores = real_scores.map{|r|r.course_d_score}
    end
    subject_max_score =subject_scores.max
    subject_min_score =subject_scores.min


    trend = subject_max_score - subject_min_score

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

  def real_scores_objects_for_nvd3_chart(student,exam_type)
    objs =[]




    if exam_type =='SAT'
      scores= student.real_scores.sat.true_real
      scores_count =scores.count

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

      #插入真实考试成绩
      scores.each_with_index do |score,i |
        total_score = score.course_a_score + score.course_b_score+ score.course_c_score


        cr_scores<<  {x:"#{score.year}年#{score.month}月(#{total_score})",y: score.course_a_score}
        math_scores<< {x:"#{score.year}年#{score.month}月(#{total_score})",y: score.course_b_score}
        grammar_scores<<  {x:"#{score.year}年#{score.month}月(#{total_score})",y: score.course_c_score}
      end




      objs=[{key:'阅读',values:cr_scores},{key:'数学',values:math_scores},{key:'语法',values:grammar_scores}]



    elsif @training_class.exam_type =='TOEFL'
      scores= student.real_scores.toefl.true_real
      scores_count =scores.count

      listen_scores = []
      talk_scores = []
      read_scores = []
      grammar_scores=[]

      real_score = student.real_scores.toefl.entry.first
      unless real_score.nil?
        listen_scores<<{x:'入口成绩',y:real_score.course_a_score}
        talk_scores<<{x:'入口成绩',y:real_score.course_b_score}
        read_scores<<{x:'入口成绩',y:real_score.course_c_score}
        grammar_scores<<{x:'入口成绩',y:real_score.course_d_score}
      end
      #插入入口成绩
      real_score = student.real_scores.where(exam_type:'TOEFL',score_type:'最终期望成绩').first
      unless entry_score.nil?
        cr_scores<<{x:'最终期望成绩',y:real_score.course_a_score}
        math_scores<<{x:'最终期望成绩',y:real_score.course_b_score}
        grammar_scores<<{x:'最终期望成绩',y:real_score.course_c_score}

      end

      #插入目标成绩 理想目标和某月目标的值
      #...
      #...

      fix_num = cr_scores.count #fix_num值为入口成绩和目标成绩的数量

      #插入模考成绩
      scores.each_with_index do |score,i |
        listen_scores<< {x:"#{score.year}年#{score.month}月(#{total_score})",y: score.course_a_score}
        talk_scores<<   {x:"#{score.year}年#{score.month}月(#{total_score})",y: score.course_b_score}

        read_scores<<  {x:"#{score.year}年#{score.month}月(#{total_score})",y: score.course_c_score}
        grammar_scores<<  {x:"#{score.year}年#{score.month}月(#{total_score})",y: score.course_d_score}
      end

      objs=[{key:'听力',values:listen_scores},{key:'口语',values:talk_scores},{key:'阅读',values:read_scores},{key:'写作',values:grammar_scores}]
    end
    return objs
  end

end
