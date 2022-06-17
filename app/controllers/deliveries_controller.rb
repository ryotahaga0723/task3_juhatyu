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

    if @delivery.save
      @status = Status.find(@delivery.order.status.id)
      @status.update!(
          status: 2
        )
      
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
