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


end
