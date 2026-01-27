module Api
  class RandomQuoteService
    def self.call
      new.call
    end

    def call
      Client.get("/random_quotes/index")
    end
  end
end