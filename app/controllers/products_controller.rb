class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def show
    @product = Product.find(params[:id])
    @seller = @product.seller
    @bids = @product.bids
  end

  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to products_path }
        format.js {}
      else
        format.html {render :new, alert: "Create product failed"}
        format.js {}
      end
    end
    # p.end_time = case product_params[:auction_ends_in]
    # when "1"
    #   DateTime.now + 1.week
    # when "2"
    #   Datetime.now + 1.day
    # end
    # p.save
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :seller_id, :starting_price_string, :end_time)
  end

end
