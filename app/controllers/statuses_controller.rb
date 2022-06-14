class StatusesController < ApplicationController
  def update_1
    @status = Status.find(params[:id])
    @status.update!(
        status: 1
    )
    redirect_to orders_path(current_user.id)
  end
end
