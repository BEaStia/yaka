# frozen_string_literal: true

RSpec.describe Yaka do
  it 'has a version number' do
    expect(Yaka::VERSION).not_to be nil
  end

  it 'has publish method' do
    expect(Yaka.respond_to?(:publish_payment)).to be_truthy
  end

  describe '.publish_payment' do
    let(:amount) { { value: '200.0', currency: 'RUB' } }
    let(:payment_token) { SecureRandom.uuid }
    let(:payment) { Yaka::Payment.new(amount: amount, confirmation: { return_url: 'http://example.com' }, description: 'First payment', payment_token: payment_token, metadata: {}, client_ip: '127.0.0.1') }
    let(:account_id) { Faker::Number.number(6).to_s }
    let(:phone) { Faker::PhoneNumber.phone_number }
    let(:transaction_id) { SecureRandom.uuid }
    let(:gateway_id) { Faker::Number.number(8).to_s }
    let(:response) { { 'id' => transaction_id, 'status' => 'succeeded', 'paid' => true, 'amount' => { 'value' => '100.00', 'currency' => 'RUB' }, 'authorization_details' => { 'rrn' => gateway_id, 'auth_code' => account_id }, 'captured_at' => '2019-06-04T07:50:45.577Z', 'created_at' => '2019-06-04T07:50:42.913Z', 'description' => Faker::Movies::HarryPotter.quote, 'metadata' => {}, 'payment_method' => { 'type' => 'bank_card', 'id' => transaction_id, 'saved' => false, 'card' => { 'first6' => '555555', 'last4' => '4444', 'expiry_month' => '09', 'expiry_year' => '2019', 'card_type' => 'MasterCard' }, 'title' => 'Bank card *4444' }, 'recipient' => { 'account_id' => account_id, 'gateway_id' => gateway_id }, 'refundable' => true, 'refunded_amount' => { 'value' => '0.00', 'currency' => 'RUB' }, 'test' => true }.to_json }

    before do
      stub_request(:post, 'https://payment.yandex.net/api/v3/payments')
        .with(
          body: "{\"amount\":{\"value\":\"200.0\",\"currency\":\"RUB\"},\"confirmation\":{\"return_url\":\"http://example.com\",\"type\":\"redirect\"},\"description\":\"First payment\",\"payment_token\":\"#{payment_token}\",\"metadata\":{},\"client_ip\":\"127.0.0.1\",\"capture\":true}",
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization' => 'Basic MTIzMTIzLmNlcjpvbG9sbw==',
            'Content-Type' => 'application/json',
            'User-Agent' => 'Faraday v0.15.4'
          }
        ).to_return(status: 200, body: response, headers: { 'Content-Type' => 'application/json' })
    end

    subject { Yaka.publish_payment(payment) }

    it 'does not raise exception' do
      expect { subject }.not_to raise_exception
    end
  end

  describe '.yandex_ip?' do
    let(:valid_ipv4) { '185.71.76.4' }
    let(:invalid_ipv4) { '192.168.2.100' }
    let(:valid_ipv6) { '2a02:5180:0000:1509:0000:0000:0000:0001' }
    let(:invalid_ipv6) { '2a02:5180:0000:1519:0000:0000:0000:0000' }
    let(:invalid_ip) { 'random_string' }

    it 'should detect valid v4' do
      expect(described_class.yandex_ip?(valid_ipv4)).to be_truthy
    end

    it 'should detect invalid v4' do
      expect(described_class.yandex_ip?(invalid_ipv4)).to be_falsey
    end

    it 'should detect valid v6' do
      expect(described_class.yandex_ip?(valid_ipv6)).to be_truthy
    end

    it 'should detect invalid v6' do
      expect(described_class.yandex_ip?(invalid_ipv6)).to be_falsey
    end

    it 'should detect not existing address' do
      expect { described_class.yandex_ip?(invalid_ip) }.to raise_exception(IPAddr::InvalidAddressError)
    end
  end
end
