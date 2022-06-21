class StatusesController < ApplicationController
  def update_1
    @status = Status.find(params[:id])
    @status.update!(
      status: 1
    )
    UserMailer.with(to: @status.order.user.email, name: @status.order.user.name, order: @status.order).status_1.deliver_now
    redirect_to index_receive_orders_path(current_user.id)
  end

  def update_3
    @status = Status.find(params[:id])
    @status.update!(
      status: 3
    )

    User.left_outer_joins(:company).where(companies: {code: 100}).each do |user|
      UserMailer.with(to: user.email, name: user.company.name, order: @status.order).status_3.deliver_now
    end

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
