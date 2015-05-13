class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :product
  monetize :bid_amount_cents

  validates :bid_amount_string, presence: true
  validate :consistent

  def bid_amount_string
    bid_amount && bid_amount.format
  end

  def bid_amount_string=(val)
    if val =~ /(\d+(\.\d+)?)/
      self.bid_amount_cents = ($1.to_f * 100).to_i # convert to cents
    else
      raise "Couldn't turn this into a price: #{val.inspect}"
    end
  end

  def consistent
    unless product.is_biddable?(self)
      errors.add(:product, "is not capable of making that bid")
    end
  end

  def greater?(other)
    self.bid_amount_string > other.bid_amount_string
  end
end
