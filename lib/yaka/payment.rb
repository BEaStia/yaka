# frozen_string_literal: true

module Yaka
  class Payment < BasicStruct
    # This class is used for sending payments to Yandex Kassa.

    # https://kassa.yandex.ru/developers/payments/54fz#54fz-payment-subject
    # commodity	            Товар
    # excise	              Подакцизный товар
    # job	                  Работа
    # service	              Услуга
    # gambling_bet	        Ставка в азартной игре
    # gambling_prize	      Выигрыш в азартной игре
    # lottery	              Лотерейный билет
    # lottery_prize	        Выигрыш в лотерею
    # intellectual_activity	Результаты интеллектуальной деятельности
    # payment	              Платеж
    # agent_commission	    Агентское вознаграждение
    # property_right	      Имущественные права
    # non_operating_gain	  Внереализационный доход
    # insurance_premium	    Страховой сбор
    # sales_tax	            Торговый сбор
    # resort_fee	          Курортный сбор
    # composite	            Несколько вариантов
    # another               Другое
    PAYMENT_SUBJECTS = Types::Strict::String.enum(
      'commodity', 'excise', 'job', 'service', 'gambling_bet',
      'gambling_prize', 'lottery', 'lottery_prize', 'intellectual_activity',
      'payment', 'agent_commission', 'property_right', 'non_operating_gain',
      'insurance_premium', 'sales_tax', 'resort_fee', 'composite', 'another'
    )


    attribute :amount, BasicStruct do
      attribute :value, Types::String
      attribute :currency, Types::String
    end
    attribute :confirmation, BasicStruct do
      attribute :type, Types::String.default('redirect')
      attribute :return_url, Types::Strict::String.meta(omittable: true)
    end
    attribute :capture, Types::Bool.default(true)
    attribute :save_payment_method, Types::Bool.meta(omittable: true)
    attribute :description, Types::Strict::String
    attribute :receipt, BasicStruct.meta(omittable: true) do
      attribute :items, Types::Array.of(BasicStruct).default([].freeze) do
        attribute :description, Types::String
        attribute :amount, BasicStruct.meta(omittable: true) do
          attribute :value, Types::String.meta(omittable: true)
          attribute :currency, Types::String.meta(omittable: true)
        end
        attribute :quantity, Types::Integer
        attribute :vat_code, Types::Integer # https://kassa.yandex.ru/docs/guides/#54fz-vat-codes
        attribute :payment_mode, Types::Strict::String.meta(omittable: true) # https://kassa.yandex.ru/developers/payments/54fz#54fz-payment-mode
        attribute :payment_subject, PAYMENT_SUBJECTS.meta(omittable: true)
      end
      attribute :phone, Types::String.meta(omittable: true).optional
      attribute :email, Types::String.meta(omittable: true).optional
      attribute :tax_system_code, Types::String.meta(omittable: true) # https://kassa.yandex.ru/developers/payments/54fz#54fz-tax-systems
    end
    attribute :payment_token, Types::String.meta(omittable: true)
    attribute :metadata, Types::Hash
    attribute :client_ip, Types::String
    attribute :payment_method_data, BasicStruct.meta(omittable: true) do
      attribute :type, Types::String
      attribute :phone, Types::String.meta(omittable: true)
    end
  end
end
