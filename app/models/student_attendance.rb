class StudentAttendance < ActiveRecord::Base
  belongs_to :student
  belongs_to :attendance

  def atten_date
    self.attendance.attendance_date
  end


  def attendance_status_icon(status)
    #返回考勤状态对应的图标
    #这个方法不应该放在model层,因为只有界面view会使用
    color = 'green' if status =='出勤'
    color = 'red' if status =='未出勤'
    color = 'blue' if status =='迟到'
    color = 'yellow' if status =='早退'
    return "<div class=\"ui #{color} label\"> </div>"

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
