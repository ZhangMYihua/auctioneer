class User < ActiveRecord::Base
  authenticates_with_sorcery!
  has_many :products, foreign_key: :seller_id
end
