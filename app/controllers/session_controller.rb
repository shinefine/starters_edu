class SessionController < ApplicationController
  #登录登出 控制器
  def create
    #用户登陆
    login_user = User.authenticate(params[:login_name], params[:password])
    #render plain: login_user
    if login_user
      session[:user_id] = login_user.id

      flash[:notice] = {:main_msg=>"欢迎您#{login_user.name}",:detail_msg => "#{login_user.role_name1} : #{login_user.name }已登录 (若想退出系统,请点击顶端信息栏上的红色[登出]按钮)"}

      flash[:need_set_password] ='你还没有设置登陆密码,建议你现在就去设置密码,请点击顶端信息栏上右上角的绿色[设置密码]按钮' if params[:password].blank?

      redirect_to(training_classes_path)

    else
      flash[:notice]= "无效的登录账户或密码"
      redirect_to root_path
    end

  end


  def destroy
  #  用户登出
    session[:user_id]=nil

    redirect_to root_path
  end
end
