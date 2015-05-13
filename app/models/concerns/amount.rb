class Amount < Struct.new(:bid_amount_string)

  include Comparable

  def <=>(other)
    self.bid_amount_string <=> other.bid_amount_string
  end

  def ==(other)
    self.bid_amount_string == other.bid_amount_string
  end


end