# frozen_string_literal: true

RSpec.describe Yaka::ReceiptItem do
  describe '#to_json' do
    let(:name) { Faker::Games::Pokemon.name }
    let(:quantity) { 5 }
    let(:price) { Yaka::Amount.new(value: 199, currency: 'RUB') }
    let(:vat_code) { 5 }

    subject { described_class.new(description: name, amount: price, quantity: quantity, vat_code: vat_code).to_json }

    it 'should make json' do
      expect(subject).to eq({ description: name, amount: price, quantity: quantity, vat_code: vat_code }.to_json)
    end
  end
end
