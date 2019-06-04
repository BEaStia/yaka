# frozen_string_literal: true

module Yaka
  class Payment < BasicStruct
    # This class is used for sending payments to Yandex Kassa.
    attribute :amount, BasicStruct do
      attribute :value, Types::String
      attribute :currency, Types::String
    end
    attribute :confirmation, BasicStruct do
      attribute :type, Types::String.default('redirect')
      attribute :return_url, Types::Strict::String
    end
    attribute :capture, Types::Bool.default(true)
    attribute :description, Types::Strict::String
    attribute :receipt, BasicStruct.meta(omittable: true) do
      attribute :items, Types::Array.of(BasicStruct).default([]) do
        attribute :description, Types::String
        attribute :amount, BasicStruct.meta(omittable: true) do
          attribute :value, Types::String.meta(omittable: true)
          attribute :currency, Types::String.meta(omittable: true)
        end
        attribute :quantity, Types::Integer
        attribute :vat_code, Types::String
        attribute :payment_mode, Types::Strict::String.meta(omittable: true)
        attribute :payment_subject, Types::String.meta(omittable: true)
      end
      attribute :phone, Types::String.meta(omittable: true)
      attribute :email, Types::String.meta(omittable: true)
      attribute :tax_system_code, Types::String.meta(omittable: true)
    end
    attribute :payment_token, Types::String
    attribute :metadata, Types::Hash
    attribute :client_ip, Types::String
  end
end
