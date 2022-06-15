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
    redirect_to index_receive_orders_path(current_user.id)
  end

  def update_order
    @approval = Approval.find(params[:id])
    @approval.update!(
      approval: 1
    )
    redirect_to orders_path(current_user.id)
  end

end
