class DeliveriesController < ApplicationController

  def new
    @delivery = Delivery.new
  end

  def create
    @delivery = Delivery.new(delivery_params)

    respond_to do |format|
      if @delivery.save
        format.html { redirect_to supplies_url, notice: "販売商品を登録しました" }
        format.json { render :show, status: :created, location: @supply }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @supply.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
  def delivery_params
    params.require(:delivery).permit(:arrive_date, :delivery_company, :delivery_number, :order_id)
  end

    
end
