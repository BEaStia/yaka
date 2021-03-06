# frozen_string_literal: true

module Yaka
  module ClassMethods
    def publish_payment(data, token = nil)
      conn = Faraday.new(url: Yaka::HOST_URL) # create a new Connection with base URL
      conn.basic_auth(Yaka.config.shop_id, Yaka.config.private_key) # set the Authentication header

      @result = conn.post do |req|
        req.url Yaka::PAYMENTS_URL
        req.headers['Content-Type'] = 'application/json'
        req.headers['Idempotence-Key'] = token
        req.body = data.to_json
      end

      body = JSON.parse(@result.body)
      raise Yaka::Error, body['description'] if body.dig('code').to_s.include?('error')

      body
    end

    def yandex_ip?(ip)
      addr = IPAddr.new(ip)

      if addr.ipv4?
        Yaka::ALLOWED_YANDEX_V4_MASKS.any? { |mask, length| addr.mask(length) == mask }
      elsif addr.ipv6?
        Yaka::ALLOWED_YANDEX_V6_MASKS.any? { |mask, length| addr.mask(length) == mask }
      else
        raise Yaka::Error, 'Invalid request ip address'
      end
    end
  end
end
