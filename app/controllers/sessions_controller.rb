class SessionsController < ApplicationController
    skip_before_action :login_required, only: [:new, :create] 
  
    def new
    end
  
    def create
      user = User.find_by(email: params[:session][:email].downcase)
      if user&.authenticate(params[:session][:password])
        log_in(user)
        flash[:notice] = 'ログインしました'
        if user.company.code == 100
          redirect_to index_receive_orders_path(user.id)
        else
          redirect_to orders_path(user.id)
        end
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
  