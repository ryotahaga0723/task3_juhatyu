class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]

  # GET /products or /products.json
  def index
    @products = Product.all

  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
    @product.build_stock
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)
    respond_to do |format|
      if @product.save

        @supply = Supply.left_outer_joins(:product).where(products: {category_id: @product.category_id}).count

        if @supply + 1 < 10
          code = "00" + (@supply + 1).to_s
        elsif @supply + 1 >= 10 && @supply + 1 < 100
          code = "0" + (@supply + 1).to_s
        else
          code = (@supply + 1).to_s
        end

        @supply = Supply.create!(
          code: @product.company.code.to_s + @product.category.id.to_s + code.to_s + "9",
          name: @product.name,
          price: 0,
          set: 1,
          content: @product.content,
          product_id: @product.id,
          stock_id: @product.stock.id
        )

        Cancel.create!(
          cancel: true,
          supply_id: @supply.id
        )
    
        format.html { redirect_to products_url, notice: "在庫を登録しました" }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to products_url, notice: "在庫を更新しました" }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url, notice: "在庫を削除しました" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :content, :image, :company_id, :category_id, stock_attributes: [:id, :quantity, :company_id, :user_id])
    end
end
