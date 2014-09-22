class User < ActiveRecord::Base
  #账户可能是一个学员/讲师/员工
  has_one :student
  has_one :teacher
  has_one :employee




  # 登录认证方法
  def self.authenticate(account_name,password)

    user = User.find_by(phone_number: account_name)

    if  user.nil?
      return nil
    end

    return nil if user.employee? && user.employee.freezing_flag
    return nil if user.teacher? && user.teacher.freezing_flag
    return nil if user.student? && user.student.freezing_flag

    if  user.password.nil?
      return user
    end

    if (user.password == password)
      return user
    end

    return nil
  end

  def role_name1
    str_role =''
    str_role<<'[学员]' if self.student?
    str_role<<'[讲师]' if self.teacher?
    str_role<<'[员工]' if self.employee?
    return str_role

  end

  # accepts_nested_attributes_for :user

  def student?
    not self.student.nil?
  end
  def teacher?
    not self.teacher.nil?
  end

  def employee?
    not self.employee.nil?
  end

  def admin?
     self.employee? && self.employee.admin?
  end


  #判断当前用户是否是指定培训班的班主任(如果当前用户是员工的情况)
  def is_training_class_master?(training_class)
    return false if training_class.master_teacher.nil?

    return false unless employee?

    return training_class.master_teacher.id == employee.id

  end
  #用户权限判定的函数

  #能否查看针对某学员的某条评语信息
  def can_see_comment?(comment)


    return false if self.teacher? && self.teacher.id != comment.teacher.id #老师只能看到自己写的评语

    return true  # 学员,员工(包括管理员) 都能查看所有评语信息
  end

  def can_set_user_password?(z_user)
    return can_set_employee_info?(z_user.employee) if  z_user.employee?
    return can_set_student_info?(z_user.student) if z_user.student?
    return can_set_teacher_info?(z_user.teacher) if z_user.teacher?

    return false
  end

  def can_set_student_info?(z_student)
    return true if employee?

    return z_student == self.student if self.student?

    return false
  end

  def can_set_teacher_info?(z_teacher)
    return true if employee?
    return z_teacher == self.teacher if self.teacher?
    return false
  end

  def can_set_employee_info?(z_employee)
    return true if role_name=="校长" || role_name=='管理员'
    return z_employee == self.employee if self.employee?
    return false
  end

  #能否新增,修改,删除 作业
  def can_edit_homework?(homework)
    #老师有创建作业对功能,老师能够修改,删除自己创建的作业
    return self.teacher? if homework.nil?

    return homework.teacher.id == teacher.id  if teacher?

    return true if employee? && is_training_class_master?(homework.training_class)

    return false

  end

  #能否管理基本数据信息
  def can_manage_basic_data?
    role_name == '管理员' || role_name=='校长'
  end

  #能否给培训班设置模考
  def can_set_training_class_examination?
    role_name == '管理员' || role_name=='校长'
  end
  #能否给设置(新增,修改,删除)培训班信息
  def can_set_training_class_info?
    role_name == '管理员' || role_name=='校长'
  end

  # #能否看见此培训班
  # def can_view_all_training_class?(training_class)
  #   return true if role_name == '管理员' || role_name=='校长'
  #
  #   return false if training_class.master_teacher.nil?
  #
  #
  #   return true if training_class.master_teacher.id == employee.id if employee?
  #
  #   return false
  #
  # end

  #能否收取作业
  def can_recieve_homework?(homework)

    #班主任 可以收取本班的作业
    unless homework.training_class.master_teacher.nil?
      return self.employee.id == homework.training_class.master_teacher.id  if self.employee?
    end

    return false

  end
end
