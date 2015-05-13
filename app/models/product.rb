require 'time_diff'

class Product < ActiveRecord::Base
  belongs_to :seller, class_name: 'User'
  has_many :bids
  monetize :starting_price_cents

  def remaining_time
    # binding.pry
    if self.end_time > Time.now.utc
      t = Time.diff(self.end_time, Time.zone.now)
      t[:diff]
    else
      "This auction has closed"
    end
  end

  def top_bid   
    bid = self.bids.sort do |bid, other_bid|
      bid.bid_amount_string <=> other_bid.bid_amount_string
    end
    bid.first
  end

  def is_biddable?(requested_bid)
    in_time = self.end_time > Time.now.utc
    first = self.bids.none?
    
    biddable = if first == true
      true
    else 
      requested_bid.greater?(self.top_bid)
    end
    
    in_time && biddable
  end

  def strf_time
    self.end_time.strftime("%Y/%m/%d %H:%M:%S")
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
