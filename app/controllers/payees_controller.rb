class PayeesController < ApplicationController

  def edit
    @payee = Payee.find(params[:id])
  end

  def update
    @payee = Payee.find(params[:id])
    if @payee.update(payee_params)
      redirect_to company_path(current_user.company), notice: "口座を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def payee_params
    params.require(:payee).permit(:bank, :branch, :kind, :number, :company_id)
  end

end
