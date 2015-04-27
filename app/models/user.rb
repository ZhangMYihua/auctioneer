class User < ActiveRecord::Base
  authenticates_with_sorcery!
  has_many :products, foreign_key: :seller_id
  has_many :bids
  has_many :products, through: :bids
end
