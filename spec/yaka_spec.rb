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
    it 'sends publication' do
      p Yaka.publish_payment(payment)
    end
  end
end
