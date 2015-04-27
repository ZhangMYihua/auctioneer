class Product < ActiveRecord::Base
belongs_to :seller, class_name: 'User', foreign_key: :seller_id
has_many :bids
monetize :starting_price_cents
end
