require 'time_diff'

class Product < ActiveRecord::Base
  belongs_to :seller, class_name: 'User'
  has_many :bids
  monetize :starting_price_cents
  belongs_to :buyer, class_name: 'User'
  
  validates :email, uniqueness: true
  validates :password, length: { minimum: 6 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  def remaining_time
    if self.end_time > Time.now.utc
      t = Time.diff(self.end_time, Time.zone.now)
      t[:diff]
    else
      "This auction has closed"
    end
  end

  
  def top_bid   
    bids = self.bids.sort do |bid, other_bid|
      other_bid.bid_amount_string <=> bid.bid_amount_string
    end
    bids.first
  end
  
  def display_bid
    unless self.bids.none? 
      self.top_bid.bid_amount_string
    end 
  end

  def is_biddable?(requested_bid)
    in_time = self.end_time > Time.now.utc
    first_bid = self.bids.none? && (requested_bid.bid_amount_string > self.starting_price_string)
    
    if self.bids.any? 
      biddable = requested_bid.greater?(self.top_bid) 
    end
    
    in_time && (first_bid || biddable)
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
