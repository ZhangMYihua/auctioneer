class ProductsController < ApplicationController
  def index
  end

  def new
  end

  def show
    @product = Product.find(params[:id])
    @seller = @product.seller
  end

  def create
    p = Product.new(product_params)
    p.end_time = case product_params[:auction_ends_in]
    when "1"
      DateTime.now + 1.week
    when "2"
      Datetime.now + 1.day
    end
    p.save
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def product_params
    params.require(:product).permit(:name, :auction_ends_in)
  end
end
