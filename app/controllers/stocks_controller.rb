class StocksController < ApplicationController
   
  def search
    
    if params[:stock]
     
     # define instance variable by looking up the stock in the database
     @stock = Stock.find_by_ticker(params[:stock])
     
     # If not there set up new record and store in the instance variable
     @stock ||= Stock.new_from_lookup(params[:stock])
     
    end
    
    if @stock
      render partial: 'lookup'
    else
      render status: :not_found, nothing: :true
    end
  
  end

end