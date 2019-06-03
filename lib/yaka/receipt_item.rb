# frozen_string_literal: true

module Yaka
  class ReceiptItem < SerializableObject
    # Vat codes
    #
    # 1: Без НДС
    # 2: НДС по ставке 0%
    # 3: НДС по ставке 10%
    # 4: НДС чека по ставке 20%
    # 5: НДС чека по расчетной ставке 10/110
    # 6: НДС чека по расчетной ставке 20/120
    #
    # Payment subjects
    # commodity:                Товар
    # excise:                   Подакцизный товар
    # job:                      Работа
    # service:                  Услуга
    # gambling_bet:             Ставка в азартной игре
    # gambling_prize:           Выигрыш в азартной игре
    # lottery:                  Лотерейный билет
    # lottery_prize:            Выигрыш в лотерею
    # intellectual_activity:    Результаты интеллектуальной деятельности
    # payment:                  Платеж
    # agent_commission:         Агентское вознаграждение
    # property_right:           Имущественные права
    # non_operating_gain:       Внереализационный доход
    # insurance_premium:        Страховой сбор
    # sales_tax:                Торговый сбор
    # resort_fee:               Курортный сбор
    # composite:                Несколько вариантов
    # another:                  Другое
    #
    # Payment mode
    # full_prepayment:          Полная предоплата
    # partial_prepayment:       Частичная предоплата
    # advance:                  Аванс
    # full_payment:             Полный расчет
    # partial_payment:          Частичный расчет и кредит
    # credit:                   Кредит
    # credit_payment:           Выплата по кредиту
    REQUIRED_FIELDS = %i[description amount quantity vat_code].freeze
    OPTIONAL_FIELDS = %i[payment_subject payment_mode].freeze

    attr_accessor(*REQUIRED_FIELDS)
    attr_accessor(*OPTIONAL_FIELDS)

    def initialize(description:, amount:, quantity:, vat_code:, payment_subject: nil, payment_mode: nil)
      @description = description
      @amount = amount
      @quantity = quantity
      @vat_code = vat_code
      @payment_subject = payment_subject
      @payment_mode = payment_mode
    end

    def to_json(*_args)
      {
        description: @description,
        amount: @amount,
        quantity: @quantity,
        vat_code: @vat_code
      }.to_json
    end
  end
end
