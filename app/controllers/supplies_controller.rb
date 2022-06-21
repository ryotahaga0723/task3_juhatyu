class SuppliesController < ApplicationController
  before_action :set_supply, only: %i[ show edit update destroy ]

  # GET /supplies or /supplies.json
  def index
    @supplies = Supply.left_outer_joins(:cancel).where(cancels: {cancel: false}).order(code: :ASC)
    @supplies_cancel = Supply.left_outer_joins(:cancel).where(cancels: {cancel: true}).order(code: :ASC)
  end

  # GET /supplies/1 or /supplies/1.json
  def show
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /supplies/new
  def new
    @supply = Supply.new
  end

  def ajax
    @product = Product.find(params[:product_id])
    respond_to do |format|
      format.js{render :ajax}
    end
  end


  # GET /supplies/1/edit
  def edit
  end

  # POST /supplies or /supplies.json
  def create
    @supply = Supply.new(supply_params)

    respond_to do |format|
      if @supply.save

        Cancel.create!(
          supply_id: @supply.id
        )

        format.html { redirect_to supplies_url, notice: "販売商品を登録しました" }
        format.json { render :show, status: :created, location: @supply }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @supply.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /supplies/1 or /supplies/1.json
  def update
    respond_to do |format|
      if @supply.update(supply_params)
        format.html { redirect_to supplies_url, notice: "販売商品を更新しました" }
        format.json { render :show, status: :ok, location: @supply }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @supply.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /supplies/1 or /supplies/1.json
  def destroy
    @supply.destroy

    respond_to do |format|
      format.html { redirect_to supplies_url, notice: "販売商品を削除しました" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_supply
      @supply = Supply.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def supply_params
      params.require(:supply).permit(:code, :name, :price, :set, :content, :product_id, :stock_id)
    end
end
