class OrdersController < ApplicationController

  # GET /orders or /orders.json
  #発注業者側
  ##月ごとの発注一覧
  def index
    @month = params[:month] ? Date.parse(params[:month]) : Time.zone.today
    @orders = Order.left_outer_joins(:approval, :user).where(created_at: @month.all_month).where(approvals: {approval: 0}).where(users: {company_id: current_user.company.id})
    @orders_approval = Order.left_outer_joins(:approval, :user).where(created_at: @month.all_month).where(approvals: {approval: 1}).where(users: {company_id: current_user.company.id})
    @orders_receive = Order.left_outer_joins(:status, :user).where(created_at: @month.all_month).where.not(statuses: {status: "新規受付"}).where.not(statuses: {status: "受注不可"}).where(users: {company_id: current_user.company.id})
    @supplies = Supply.where(id: OrderSupply.left_outer_joins(order: :user).where(users: {company_id: current_user.company.id}).group(:order_id).order('sum(quantity) desc').pluck(:order_id))
  end

  def index_supply
    @supply = Supply.find(params[:format])
    @product = @supply.product
    @order_supplies = OrderSupply.left_outer_joins(supply: :product).where(products: {name: @product.name}).where(products: {company_id: @product.company.id})
  end


  #受注業者側
  ##受注日ごと
  def index_receive
    @day = params[:day] ? Date.parse(params[:day]) : Time.zone.today
    @orders = Order.left_outer_joins(:approval).where(created_at: @day.all_day).where(approvals: {approval: 1})
  end

  #受注月ごと
  def index_receive_month
    @month = params[:month] ? Date.parse(params[:month]) : Time.zone.today
    @orders = Order.left_outer_joins(:approval).where(created_at: @month.all_month).where(approvals: {approval: 1})
  end


  # GET /orders/1 or /orders/1.json
  def show
    @order = Order.find(params[:id])
  end

  # GET /orders/new
  def new
    @order = Order.new
    @order.build_address
    @order.build_telephone
    @order.build_shipping
    @order.build_status
    Supply.all.each do |supply|
      @order.order_supplies.build(supply_id: supply.id)
    end
    @supply = Supply.all
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  def confirm
    @order = Order.new(order_params)

    if @order.invalid? #入力項目に空のものがあれば入力画面に遷移
      render :new
    end
  end

  def back
		@order = Order.new(order_params)
		render :new
	end

  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params)
    @total_price = 0
    @order.order_supplies.each do |f|
      if f.availability == true
        unless f.quantity.nil?
          totalsub = f.supply.price * f.quantity
          @total_price += totalsub  
        end
      else
        f.quantity = 0
      end
    end

    if @order.save
      @order.update(total_price: @total_price)

      Approval.create!(
        approval: 0,
        user_id: current_user.id,
        approvalable_type: "Order",
        approvalable_id: @order.id,
      )

      redirect_to order_url(@order), notice: "注文内容を作成しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    @order = Order.find(params[:id])
    @total_price = 0
    @order.order_supplies.each do |f|
      totalsub = f.supply.price * f.quantity
      @total_price += totalsub
    end
    @order.update(total_price: @total_price)


    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to order_url(@order), notice: "注文内容を更新しました" }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: "注文内容を削除しました" }
      format.json { head :no_content }
    end
  end

  def ajax
    @order = Order.find(params[:format])
    respond_to ajax.js
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:code, :date, :total_price, :user_id, 
        order_supplies_attributes: [:id, :availability, :quantity, :supply_id, :_destroy], 
        order_wills_attributes: [:id, :quantity, :product_id], 
        status_attributes: [:id, :status],
        address_attributes: [:id, :postcode, :prefecture_code, :prefecture, :city, :town, :address, :building, :room_number], 
        telephone_attributes: [:id, :number], 
        shipping_attributes: [:id, :name]
      )
    end
end
