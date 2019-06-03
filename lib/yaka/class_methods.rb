# frozen_string_literal: true

module Yaka
  module ClassMethods
    HOST_URL = 'https://payment.yandex.net'
    PAYMENTS_URL = '/api/v3/payments'

    def publish_payment(payment, token = nil)
      raise Yaka::Error, 'Only payment should be sent to API' unless payment.is_a?(Yaka::Payment)

      data = payment.to_json

      conn = Faraday.new(url: HOST_URL) # create a new Connection with base URL
      conn.basic_auth(Yaka.config.shop_id, Yaka.config.private_key) # set the Authentication header

      @result = conn.post do |req|
        req.url PAYMENTS_URL
        req.headers['Content-Type'] = 'application/json'
        req.headers['Idempotence-Key'] = token
        req.body = data
      end

      JSON.parse(@result.body)
    end
  end
end
