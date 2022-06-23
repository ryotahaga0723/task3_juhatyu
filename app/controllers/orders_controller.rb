class OrdersController < ApplicationController

  # GET /orders or /orders.json
  #発注業者側
  ##月ごとの発注一覧
  def index
    @month = params[:month] ? Date.parse(params[:month]) : Time.zone.today
    @orders = Order.left_outer_joins(:approval, :user).where(created_at: @month.all_month).where(approvals: {approval: 0}).where(users: {company_id: current_user.company.id})
    @orders_approval = Order.left_outer_joins(:approval, :user).where(created_at: @month.all_month).where(approvals: {approval: 1}).where(users: {company_id: current_user.company.id})
    @orders_receive = Order.left_outer_joins(:status, :user).where(created_at: @month.all_month).where.not(statuses: {status: "新規受付"}).where.not(statuses: {status: "受注不可"}).where(users: {company_id: current_user.company.id})
    @supplies = Supply.where(id: OrderSupply.left_outer_joins(order: :user).where(users: {company_id: current_user.company.id}).group(:order_id).order('sum(order_id) desc').pluck(:order_id))
  end

  def index_supply
    @month = params[:month] ? Date.parse(params[:month]) : Time.zone.today
    @supply = Supply.find(params[:supply])
    @product = @supply.product
    @order_supplies = OrderSupply.left_outer_joins(supply: :product).where(products: {name: @product.name}).where(products: {company_id: @product.company.id}).where(created_at: @month.all_month)
    @order_supplies_sum =0
    @order_supplies.each do |os|
      @order_supplies_sum += (os.quantity * @supply.price)
    end

  end


  #受注業者側
  ##受注日ごと
  def index_receive
    @day = params[:day] ? Date.parse(params[:day]) : Time.zone.today
    @orders = Order.left_outer_joins(:approval, :status).where(created_at: @day.all_day).where(approvals: {approval: 1})
    @orders_0 = @orders.where(statuses: {status: 0}).count
    @orders_1 = @orders.where(statuses: {status: 1}).count
    @orders_2 = @orders.where(statuses: {status: 2}).count
    @orders_3 = @orders.where(statuses: {status: 3}).count
    @orders_4 = @orders.where(statuses: {status: 4}).count
    @orders_5 = @orders.where(statuses: {status: 5}).count
    @orders_6 = @orders.where(statuses: {status: 6}).count
  end

  #受注月ごと
  def index_receive_month
    @month = params[:month] ? Date.parse(params[:month]) : Time.zone.today
    @orders = Order.left_outer_joins(:approval, :status).where(created_at: @month.all_month).where(approvals: {approval: 1})
    @orders_0 = @orders.where(statuses: {status: 0}).count
    @orders_1 = @orders.where(statuses: {status: 1}).count
    @orders_2 = @orders.where(statuses: {status: 2}).count
    @orders_3 = @orders.where(statuses: {status: 3}).count
    @orders_4 = @orders.where(statuses: {status: 4}).count
    @orders_5 = @orders.where(statuses: {status: 5}).count
    @orders_6 = @orders.where(statuses: {status: 6}).count
  end

  #発送日ごと
  def index_receive_delivery
    @day = params[:day] ? Date.parse(params[:day]) : Time.zone.today
    @orders = Order.left_outer_joins(:approval).where(date: (@day +1).all_day).where(approvals: {approval: 1})
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
    @supply = Supply.left_outer_joins(:cancel).where(cancels: {cancel: false})
    @supply.each do |supply|
      @order.order_supplies.build(supply_id: supply.id)
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
    @supply = Supply.all
  end

  def confirm
    @order = Order.new(order_params)

    if @order.invalid? #入力項目に空のものがあれば入力画面に遷移
      @supply = Supply.left_outer_joins(:cancel).where(cancels: {cancel: false})
      render :new
    end
  end

  def back
		@order = Order.new(order_params)
    @supply = Supply.left_outer_joins(:cancel).where(cancels: {cancel: false})
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
      @supply = Supply.left_outer_joins(:cancel).where(cancels: {cancel: false})
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
        @supply = Supply.left_outer_joins(:cancel).where(cancels: {cancel: false})
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
    @supply = Supply.find(params[:supply])
    respond_to do |format|
      format.js{render :ajax} 
    end
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
