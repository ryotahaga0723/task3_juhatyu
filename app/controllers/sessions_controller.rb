class SessionsController < ApplicationController
    skip_before_action :login_required, only: [:new, :create] 
  
    def new
    end
  
    def create
      user = User.find_by(email: params[:session][:email].downcase)
      if user&.authenticate(params[:session][:password])
        log_in(user)
        flash[:notice] = 'ログインしました'
        redirect_to companies_path(user.id)
      else
        flash.now[:danger] = 'メールアドレスまたはパスワードに誤りがあります'
        render :new
      end
    end
  
    def destroy
      session.delete(:user_id)
      flash[:notice] = 'ログアウトしました'
      redirect_to new_session_path
    end
  end
  