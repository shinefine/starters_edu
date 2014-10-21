class DictationScore < ActiveRecord::Base
  belongs_to :student
  belongs_to :dictation

  def execute_date
    self.dictation.execute_date
  end

  def css_style
    score = self.score || -1
    if (score >= self.dictation.passing_line)
      return 'lightred'
    elsif(score>=0)
      return 'lightgreen'
    else
      return 'lightblue'
    end
    return ''
  end

  def description

    return '(未听写)' if score.nil? || score<0
    return score
  end
end
