class Attendance < ActiveRecord::Base
  belongs_to :training_class  #属于某个培训班
  has_many :student_attendances  ,dependent: :delete_all
  accepts_nested_attributes_for :student_attendances  ,
                                allow_destroy: true



  def summary_text
     group_result =self.student_attendances.group_by{|item| item.description}

     col= group_result.map{|key,value|
       "#{group_result[key].length}人 #{key} "
    }
    return col.join(',')
  end
end
