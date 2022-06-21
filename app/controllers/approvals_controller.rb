class ApprovalsController < ApplicationController
  def update_invoice
    @approval = Approval.find(params[:id])
    @invoice = Invoice.find(@approval.approvalable_id)
    @status = Status.find(@invoice.order.status.id)
    @approval.update!(
      approval: 1
    )
    @status.update!(
      status: 5
    )

    @order = @status.order

    UserMailer.with(to: @order.user.email, name: @order.user.name, order: @order).send_invoice.deliver_now

    redirect_to index_receive_orders_path(current_user.id)
  end

  def update_order
    @approval = Approval.find(params[:id])
    @order = Order.find(@approval.approvalable_id)
    @approval.update!(
      approval: 1
    )
    User.left_outer_joins(:company).where(companies: {code: 100}).each do |user|
      UserMailer.with(to: user.email, name: user.company.name, order: @order).order_approval.deliver_now
    end

    redirect_to orders_path(current_user.id)
  end

end
