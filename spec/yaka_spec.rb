RSpec.describe Yaka do
  it "has a version number" do
    expect(Yaka::VERSION).not_to be nil
  end

  it "has publish method" do
    expect(Yaka.respond_to?(:publish_payment)).to be_truthy
  end

  describe '.publish_payment' do
    let(:amount) { Yaka::Amount.new(value: "200.0") }

    let(:payment) { Yaka::Payment.new(amount: amount) }

    before do
      stub_request(:post, "#{Yaka::ClassMethods::HOST_URL}/#{Yaka::ClassMethods::PAYMENTS_URL}").
          with(
              body: "{\"amount\":{\"value\":\"200.0\",\"currency\":\"RUB\"},\"confirmation\":{\"type\":\"redirect\",\"return_url\":\"http://example.com\"},\"capture\":true}",
              headers: {
                  'Accept'=>'*/*',
                  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                  'Authorization'=>'Basic MTIzMTIzLmNlcjpvbG9sbw==',
                  'Content-Type'=>'application/json',
                  'User-Agent'=>'Faraday v0.15.4'
              }).
          to_return(status: 200, body: "", headers: {})
    end

    subject { Yaka.publish_payment(payment) }

    it 'sends publication' do
      expect { subject }.not_to raise_exception
    end
  end
end
