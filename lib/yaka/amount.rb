# frozen_string_literal: true

module Yaka
  class Amount < SerializableObject
    REQUIRED_FIELDS = %i[value currency].freeze
    OPTIONAL_FIELDS = %i[].freeze

    attr_accessor(*REQUIRED_FIELDS)

    def initialize(value:, currency: 'RUB')
      @value = value
      @currency = currency
    end
  end
end
