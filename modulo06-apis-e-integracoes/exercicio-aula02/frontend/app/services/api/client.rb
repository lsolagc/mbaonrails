module Api
  class Client
    include HTTParty

    headers 'Content-Type' => 'application/json'

    base_uri "localhost:3000"
  end
end
