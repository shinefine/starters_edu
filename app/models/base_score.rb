module BaseScore
  def calculate_total_score(score,exam_type)
    total_score = 0
    if exam_type =='SAT'
      total_score = score.sat_cr_score + score.sat_math_score+ score.sat_writing_score

    elsif exam_type == 'TOEFL'
      total_score = score.toefl_listening_score + score.toefl_speaking_score+ score.toefl_reading_score+ score.toefl_writing_score
    end
    return total_score
  end
end