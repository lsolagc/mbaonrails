class QuoterController < ApplicationController
  def index
    @quote = Api::RandomQuoteService.call
  end
end
