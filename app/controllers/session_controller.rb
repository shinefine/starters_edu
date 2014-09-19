class SessionController < ApplicationController
  #登录登出 控制器
  def create
    #用户登陆
    login_user = User.authenticate(params[:login_name], params[:password])
    #render plain: login_user
    if login_user
      session[:user_id] = login_user.id

      flash[:notice] = login_user.role_name1 + ":" + login_user.name + " 已登录"


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
