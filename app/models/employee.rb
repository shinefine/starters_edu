class Employee < ActiveRecord::Base

  #员工可能登录系统,所以有一个对应的账户
  belongs_to :user


  #定义员工信息时的Form 能够同时定义其登录账户的信息
  accepts_nested_attributes_for :user

  def name
    self.user.name
  end
end
