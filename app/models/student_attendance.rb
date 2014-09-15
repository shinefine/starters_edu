class StudentAttendance < ActiveRecord::Base
  belongs_to :student
  belongs_to :attendance

  def atten_date
    self.attendance.attendance_date
  end

  def css_style
    case self.description
      when '迟到'
        return  'lightblue'
      when '早退'
        return 'lightyellow'
      when '出勤'
        return 'lightgreen'
      when '未出勤'
        return 'lightred'

    end
    return ''
  end
end
