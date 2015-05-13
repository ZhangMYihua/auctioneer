class BidsController < ApplicationController
  before_filter :load_product
  before_filter :ensure_logged_in, only: [:create, :destroy]

  def new

  end

  def create
    @bid = @product.bids.build(bids_params)
    @bid.user = current_user

    if @bid.save
      redirect_to product_path(:product_id), notice: 'Bid made!'
    else
      render 'products/show'
    end
  end

  def show
    @bid = Bid.find(params[:id])
  end

private
  def bids_params
    params.require(:bid).permit(:product_id, :bid_amount_string)
  end

  def load_product 
    @product = Product.find(params[:product_id]) 
  end
end
