# frozen_string_literal: true

module Yaka
  class Payment < SerializableObject

    REQUIRED_FIELDS = %i[amount confirmation capture].freeze
    OPTIONAL_FIELDS = %i[description receipt payment_token metadata].freeze

    attr_accessor(*REQUIRED_FIELDS)
    attr_accessor(*OPTIONAL_FIELDS)

    def initialize(amount:, client_ip: nil, description: nil, metadata: nil, receipt: nil, payment_token: nil, confirmation: { type: "redirect", return_url: Yaka.config.redirect_url}, capture: true)
      @amount = amount
      @receipt = receipt
      @description = description
      @payment_token = payment_token
      @confirmation = confirmation
      @capture = capture
      @metadata = metadata
      @client_ip = client_ip
    end
  end
end
