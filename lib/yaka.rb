# frozen_string_literal: true

require 'dry-configurable'
require 'dry-struct'
require 'ipaddr'
require 'date'

require 'yaka/version'
require 'yaka/basic_struct'
require 'yaka/class_methods'
require 'yaka/payment'
require 'yaka/payment_response'

require 'faraday'

module Yaka
  HOST_URL = 'https://payment.yandex.net'
  PAYMENTS_URL = '/api/v3/payments'
  ALLOWED_YANDEX_V4_MASKS = {
    '185.71.76.0' => 27,
    '185.71.77.0' => 27,
    '77.75.153.0' => 25,
    '77.75.154.128' => 25
  }.freeze

  ALLOWED_YANDEX_V6_MASKS = {
    '2a02:5180:0:1509::' => 64,
    '2a02:5180:0:2655::' => 64,
    '2a02:5180:0:1533::' => 64,
    '2a02:5180:0:2669::' => 64
  }.freeze

  class Error < StandardError; end

  extend Dry::Configurable

  setting :shop_id, '123123.cer'

  setting :private_key, 'ololo'

  extend ClassMethods
end
