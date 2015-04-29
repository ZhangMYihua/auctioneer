require 'time_diff'

class Product < ActiveRecord::Base
  belongs_to :seller, class_name: 'User', foreign_key: :seller_id
  has_many :bids
  monetize :starting_price_cents

  def remaining_time
    if self.end_time > Time.now.utc
      t = Time.diff(self.end_time, Time.zone.now)
      return t[:diff]
    else
      return "This auction has closed"
    end
  end

  def starting_price_string
    starting_price && starting_price.format
  end

  def starting_price_string=(val)
    if val =~ /(\d+(\.\d+)?)/
      self.starting_price_cents = ($1.to_f * 100).to_i # convert to cents
    else
      raise "Couldn't turn this into a price: #{val.inspect}"
    end
  end

end
