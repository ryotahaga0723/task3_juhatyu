class InvoicesController < ApplicationController
  before_action :set_invoice, only: %i[ show edit update destroy ]

  # GET /invoices or /invoices.json
  def index
    @invoices = Invoice.all
  end

  # GET /invoices/1 or /invoices/1.json
  def show
    @company = Company.find(100)

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "請求書", 
               layout: 'pdf_layouts.html',
               template: "invoices/:id",
               encoding: 'UTF-8'
      end
    end
  end

  # GET /invoices/new
  def new
    @invoice = Invoice.new
    @invoice.invoice_contents.build
    @invoice.build_address
    @invoice.build_telephone
    @order = Order.find(params[:format])
    @order_supplies = OrderSupply.where(order_id: @order.id)
  end

  # GET /invoices/1/edit
  def edit
    @order = Order.find(params[:format])
    @order_supplies = OrderSupply.where(order_id: @order.id)
  end

  # POST /invoices or /invoices.json
  def create
    @invoice = Invoice.new(invoice_params)
    
    if @invoice.save

      @total_sum = 0
      @invoice.invoice_contents.each do |content|
        @total_sum += content.price * content.quantity
      end

      @invoice.update!(
        total_sum: @total_sum
      )

      Approval.create!(
        approval: 0,
        user_id: current_user.id,
        approvalable_type: "Invoice",
        approvalable_id: @invoice.id,
      )
  
      @status = Status.find(@invoice.order.status.id)
      @status.update!(
        status: 4
      )

      redirect_to index_receive_orders_path(current_user.id)

    else
      @order = Order.find(@invoice.order_id)
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /invoices/1 or /invoices/1.json
  def update
    if @invoice.update(invoice_params)

      @total_sum = 0
      @invoice.invoice_contents.each do |content|
        @total_sum += content.price * content.quantity
      end

      @invoice.update!(
        total_sum: @total_sum
      )

      redirect_to invoice_url(@invoice), notice: "請求書を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /invoices/1 or /invoices/1.json
  def destroy
    @invoice.destroy

    respond_to do |format|
      format.html { redirect_to invoices_url, notice: "請求書を削除しました" }
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
      params.require(:invoice).permit(:code, :total_sum, :user_id, :order_id, 
        invoice_contents_attributes: [:code, :id, :name, :set, :price, :quantity, :_destroy], 
        address_attributes: [:id, :postcode, :prefecture_code, :prefecture, :city, :town, :address, :building, :room_number], 
        telephone_attributes: [:id, :number])
    end
end
