class StatusesController < ApplicationController
  def update_1
    @status = Status.find(params[:id])
    @status.update!(
      status: 1
    )
    redirect_to index_receive_orders_path(current_user.id)
  end

  def update_3
    @status = Status.find(params[:id])
    @status.update!(
      status: 3
    )
    redirect_to orders_path(current_user.id)
  end

  def update_6
    @status = Status.find(params[:id])
    @status.update!(
      status: 6
    )
    redirect_to index_receive_orders_path(current_user.id)
  end

end
