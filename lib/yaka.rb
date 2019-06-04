# frozen_string_literal: true

require 'dry-configurable'
require 'yaka/version'
require 'yaka/serializable_object'
require 'yaka/amount'
require 'yaka/class_methods'
require 'yaka/payment'
require 'yaka/receipt'
require 'yaka/receipt_item'
require 'faraday'

module Yaka
  class Error < StandardError; end

  extend Dry::Configurable

  setting :shop_id, '123123.cer'

  setting :private_key, 'ololo'

  extend ClassMethods
end
