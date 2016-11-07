class SessionsController < ApplicationController

  def new
  end

#  def create
#    user = User.find_by(email: params[:session][:email].downcase)
#    if user && user.authenticate(params[:session][:password])
#      ## ユーザーログイン後にユーザー情報のページにリダイレクトする
#      #log_in user
#      ##remember user
#      ## チェックボックスの送信結果を処理する
#      #params[:session][:remember_me] == '1' ? remember(user) : forget(user)
#      ##redirect_to user
#      ## フレンドリーフォワーディング
#      #redirect_back_or user

#      if user.activated?
#        log_in user
#        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
#        redirect_back_or user
#      else
#        message  = "Account not activated. "
#        message += "Check your email for the activation link."
#        flash[:warning] = message
#        redirect_to root_url
#      end

#    else
#      # エラーメッセージを作成する
#      #flash[:danger] = 'Invalid email/password combination' # 本当は正しくない
#      flash.now[:danger] = 'Invalid email/password combination'
#      render 'new'
#    end
#  end
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    #log_out
    log_out if logged_in?
    redirect_to root_url
  end
end
