class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :product
  monetize :bid_amount_cents
end
