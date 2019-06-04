# frozen_string_literal: true

module Yaka
  class PaymentResponse
    ATTRIBUTES = %i[id status paid amount authorization_details captured_at
                    created_at description metadaata payment_method recipient
                    refundable refunded_amount test].freeze

    attr_accessor(*ATTRIBUTES)

    def initialize(hash = {})
      ATTRIBUTES.map do |attr_name|
        value = hash[attr_name.to_s]
        public_send("#{attr_name}=", value)
      end
    end
  end
end
