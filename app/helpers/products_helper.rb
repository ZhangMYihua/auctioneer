module ProductsHelper

  # def present_bid?(product)
  #   if product.top_bid.present?
  #     if current_user && current_user.bids.present?
  #       if current_user.bids.any? do |bid|
  #         bid.user_id == product.top_bid.user_id
  #       end
        
  #       "#{product.top_bid_amount} This is your bid!"
  #       else
  #         "#{product.top_bid_amount}"
  #       end
  #     end
  #   else
  #     "Starting Price: #{product.starting_price}"
  #   end
  # end

  def bid_wrapper(product)
    if product.bids.any?
      if product.top_bid.user == current_user
        "Your bid: #{product.top_bid_amount}"
      else
        "#{product.top_bid_amount}"
      end
    else
      "Starting Price: #{product.starting_price}"
    end
  end
end
