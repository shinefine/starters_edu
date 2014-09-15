class DictationScore < ActiveRecord::Base
  belongs_to :student
  belongs_to :dictation

  def execute_date
    self.dictation.execute_date
  end

  def css_style
    if (self.score >= self.dictation.passing_line)

        return 'lightgreen'
    else
        return 'lightred'

    end
    return ''
  end

  def description
    return score
  end
end
