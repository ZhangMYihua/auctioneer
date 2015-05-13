class BidsController < ApplicationController
  before_filter :load_product
  before_filter :ensure_logged_in, only: [:create, :destroy]

  def new
    @bid = @product.bids.new
  end

  def create
    @bid = Bid.new bids_params
    @bid.user = current_user

    # binding.pry
    if @bid.save
      redirect_to products_path, notice: 'Bid made!'
    else
      render 'products/show'
    end
  end

  def show
    @bid = Bid.find(params[:id])
  end

private
  def bids_params
    # params.require(:bid).permit(:product_id, :bid_amount_string)
    { 
      bid_amount_string: params[:bid][:bid_amount_string],
      product_id: params[:product_id]
    }
  end

  def load_product 
    @product = Product.find(params[:product_id]) 
  end
end
