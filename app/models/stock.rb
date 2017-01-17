class Stock < ActiveRecord::Base
  
  def self.find_by_ticker(ticker_symbol)
    
    # Get quote from the ticker
    where(ticker: ticker_symbol).first
    
  end
    
    
  def self.new_from_lookup(ticker_symbol)
    # Garden variety stock lookup
    looked_up_stock = StockQuote::Stock.quote(ticker_symbol)
    
    # return if stock not found
    return nil unless looked_up_stock.name
    return "Not Available" unless looked_up_stock.name
    
    # create new stock record
    new_stock = new(ticker:looked_up_stock.symbol, name:looked_up_stock.name)
    # which price used TBD
    new_stock.last_price = new_stock.price
    
    #return new stock record
    new_stock
  end
  
  
  def price
    
    # Get quote and return closing price if it is not nil
    closing_price = StockQuote::Stock.quote(ticker).close
    return "#{closing_price} (Closing)" if closing_price

    
    # Get quote and return opening price if it is not nil
    opening_price = StockQuote::Stock.quote(ticker).open
    return "#{opening_price} (Opening)" if opening_price
    
    
    # Return Unavailable if neither
    'Unavailable'
    
  end
end
