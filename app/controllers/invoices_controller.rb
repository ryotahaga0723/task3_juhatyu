class InvoicesController < ApplicationController
  before_action :set_invoice, only: %i[ show edit update destroy ]

  # GET /invoices or /invoices.json
  def index
    @invoices = Invoice.all
  end

  # GET /invoices/1 or /invoices/1.json
  def show
  end

  # GET /invoices/new
  def new
    @invoice = Invoice.new
    @invoice.invoice_contents.build
    @order = Order.find(params[:format])
    @order_supplies = OrderSupply.where(order_id: @order.code)
  end

  # GET /invoices/1/edit
  def edit
  end

  # POST /invoices or /invoices.json
  def create
    @invoice = Invoice.new(invoice_params)
    
    if @invoice.save
      Approval.create!(
        approval: 0,
        user_id: current_user.id,
        approvalable_type: "Invoice",
        approvalable_id: @invoice.code,
      )
  
      @status = Status.find(@invoice.order.status.id)
      @status.update!(
        status: 4
      )
      redirect_to index_receive_orders_path(current_user.id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /invoices/1 or /invoices/1.json
  def update
    respond_to do |format|
      if @invoice.update(invoice_params)
        format.html { redirect_to invoice_url(@invoice), notice: "Invoice was successfully updated." }
        format.json { render :show, status: :ok, location: @invoice }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1 or /invoices/1.json
  def destroy
    @invoice.destroy

    respond_to do |format|
      format.html { redirect_to invoices_url, notice: "Invoice was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def invoice_params
      params.require(:invoice).permit(:code, :total_sum, :user_id, :order_id, invoice_contents_attributes: [:id, :name, :set, :price, :quantity, :_destroy])
    end
end
