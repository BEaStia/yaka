# frozen_string_literal: true

RSpec.describe Yaka::Payment do
  describe '#to_json' do
    let(:amount) { { value: '200.0', currency: 'RUB' } }
    let(:payment_token) { SecureRandom.uuid }
    let(:name) { Faker::Games::Pokemon.name }
    let(:quantity) { 5 }
    let(:vat_code) { 5 }
    let(:phone) { Faker::PhoneNumber.cell_phone }
    let(:email) { Faker::Internet.email }
    let(:receipt_item) { { description: name, amount: price, quantity: quantity, vat_code: vat_code } }
    let(:receipt) { { items: [], email: email, phone: phone } }
    let(:payment) { Yaka::Payment.new(amount: amount, confirmation: { return_url: 'http://example.com' }, description: 'First payment', receipt: receipt, payment_token: payment_token, metadata: {}, client_ip: '127.0.0.1') }
    let(:subject) { payment.to_json}

    it 'should create object and serialize' do
      expect(JSON.parse(subject)).to eq(JSON.parse({amount: amount, confirmation: { return_url: 'http://example.com', type: 'redirect' }, receipt: {email: email, phone: phone, items: []}, description: 'First payment', payment_token: payment_token, metadata: {}, client_ip: '127.0.0.1', capture: true}.to_json))
    end

    context 'without email' do
      let(:email) { nil }

      it 'should not fait without email' do
        expect(JSON.parse(subject)).to eq(JSON.parse({amount: amount, confirmation: { return_url: 'http://example.com', type: 'redirect' }, receipt: {email: email, phone: phone, items: []}, description: 'First payment', payment_token: payment_token, metadata: {}, client_ip: '127.0.0.1', capture: true}.to_json))
      end
    end
  end
end
