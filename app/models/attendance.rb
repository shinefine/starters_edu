class Attendance < ActiveRecord::Base
  belongs_to :training_class  #属于某个培训班
  has_many :student_attendances  ,dependent: :delete_all
  accepts_nested_attributes_for :student_attendances  ,
                                allow_destroy: true


  default_scope {order('attendance_date DESC')}


  def summary_text
    #返回所有学员考勤情况的简要说明文字


    #分别计算出所有学员的上午,下午,晚上考勤情况( 以出勤结果(迟到/早退/...)分组)
    result =[]

    group_result_morning =self.student_attendances.group_by{|item| item.status_morning}

    result<< "上午:"+ group_result_morning.map {|key,value|
      "#{value.length}人 #{key} "
    }.join(',')

    group_result_afternoon =self.student_attendances.group_by{|item| item.status_afternoon}

    result<< "下午:"+ group_result_afternoon.map {|key,value|
      "#{value.length}人 #{key} "
    }.join(',')

    group_result_evening =self.student_attendances.group_by{|item| item.status_evening}

    result<< "晚上:"+ group_result_evening.map {|key,value|
      "#{value.length}人 #{key} "
    }.join(',')



    #生成描述字符串
    return result.join("\n")
  end
end
