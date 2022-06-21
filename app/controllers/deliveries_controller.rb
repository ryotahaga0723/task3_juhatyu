class DeliveriesController < ApplicationController

  def new
    @delivery = Delivery.new
    @order = Order.find(params[:format])
  end

  def edit
    @delivery = Delivery.find(params[:id])
    @order = Order.find(@delivery.order_id)
  end


  def create
    @delivery = Delivery.new(delivery_params)
    @order = @delivery.order

    if @delivery.save
      @status = Status.find(@order.status.id)
      @status.update!(
          status: 2
        )
      Stock.all.each do |st|
        st.supplies.each do |su|
          @eachsum = 0
          su.order_supplies.left_outer_joins(:order).where(orders: {id: @order.id}).each do |os|
            @eachsum = os.quantity * os.supply.set
            st.update!(
              quantity: st.quantity - @eachsum
            )
          end
        end
      end

      redirect_to index_receive_orders_path(current_user.id)
    else
        @order = Order.find(@delivery.order_id)
        render :new, status: :unprocessable_entity
    end
  end

  def update
    @delivery = Delivery.find(params[:id])

    if @delivery.update(delivery_params)
        redirect_to index_receive_orders_path(current_user.id)
      else
        @order = Order.find(@delivery.order_id)
        render :edit, status: :unprocessable_entity
      end
  end


  def show
    @delivery = Delivery.find(params[:id])
  end
  
  
  private
  def delivery_params
    params.require(:delivery).permit(:arrive_date, :delivery_company, :delivery_number, :order_id)
  end

    
end
