# frozen_string_literal: true

module Yaka
  module Types
    include Dry::Types()
  end

  class BasicStruct < Dry::Struct

    def self.primitive
      Types::Hash
    end

    transform_types do |type|
      if type.default?
        type.constructor do |value|
          value.nil? ? Dry::Types::Undefined : value
        end
      else
        type
      end
    end

    transform_keys(&:to_sym)

    def to_json(_args = {})
      attributes.to_json
    end
  end
end
