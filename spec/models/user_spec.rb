require 'spec_helper'
#用户 User 模型对象

describe User do
 before { @user=User.new }
 subject { @user }

 describe '用户 User 模型对象应该有这些属性' do

    it {should respond_to(:name) }
    it {should respond_to(:name)} #名字
    it {should respond_to(:email)} # 电子邮件地址

    it {should respond_to(:phone_number)} #手机号码
    it {should respond_to(:qq_number)} #qq号码
    it {should respond_to(:tinypost_number)} #微信号码
    it {should respond_to(:identify_card)} #身份证

    it {should respond_to(:password)} #密码
    it {should respond_to(:role_name)} #角色名

    it {should respond_to :created_at}
    it {should respond_to :updated_at}

  end
end