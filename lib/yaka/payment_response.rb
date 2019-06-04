# frozen_string_literal: true

module Yaka
  class PaymentResponse < BasicStruct
    # This class is used to wrap response from Yandex Kassa about necessary actions to complete/process if it's required

    attribute :id, Types::String
    attribute :status, Types::String
    attribute :paid, Types::Bool
    attribute :amount, BasicStruct do
      attribute :value, Types::String
      attribute :currency, Types::String
    end
    attribute :authorization_details, BasicStruct do
      attribute :rrn, Types::String
      attribute :auth_code, Types::String
    end
    attribute :captured_at, Types::DateTime
    attribute :created_at, Types::DateTime
    attribute :description, Types::String
    attribute :metadata, Types::Hash
    attribute :payment_method, BasicStruct do
      attribute :id, Types::String
      attribute :type, Types::String
      attribute :saved, Types::String
      attribute :title, Types::String
      attribute :card, BasicStruct do
        attribute :first6, Types::String
        attribute :last4, Types::String
        attribute :expiry_month, Types::String
        attribute :expiry_year, Types::String
        attribute :card_type, Types::String
      end
    end
    attribute :recipient, BasicStruct do
      attribute :account_id, Types::String
      attribute :gateway_id, Types::String
    end
    attribute :refundable, Types::Bool
    attribute :refunded_amount, BasicStruct do
      attribute :value, Types::String
      attribute :currency, Types::String
    end
    attribute :test, Types::Bool
  end
end
