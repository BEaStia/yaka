# frozen_string_literal: true

module Yaka
  class Receipt < SerializableObject
    # Tax system codes
    # 1:  Общая система налогообложения
    # 2:  Упрощенная (УСН, доходы)
    # 3:  Упрощенная (УСН, доходы минус расходы)
    # 4:  Единый налог на вмененный доход (ЕНВД)
    # 5:  Единый сельскохозяйственный налог (ЕСН)
    # 6:  Патентная система налогообложения

    REQUIRED_FIELDS = %i[items].freeze
    OPTIONAL_FIELDS = %i[phone email tax_system_code].freeze

    attr_accessor(*REQUIRED_FIELDS)
    attr_accessor(*OPTIONAL_FIELDS)

    def initialize(items: [], phone: nil, email: nil, tax_system_code: nil)
      @items = items
      @phone = phone
      @email = email
      @tax_system_code = tax_system_code
      raise Yaka::Error, 'Invalid input parameters: phone or email should be present' if @phone.nil? && @email.nil?
    end
  end
end
