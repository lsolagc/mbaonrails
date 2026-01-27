module Api
  class Client
    include HTTParty
    base_uri Rails.configuration.x.api_url
  end
end
