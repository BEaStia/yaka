RSpec.describe Yaka::Receipt do
  describe '#to_json' do

    let(:name) { Faker::Games::Pokemon.name }
    let(:quantity) { 5 }
    let(:price) { Yaka::Amount.new(value: 199, currency: "RUB") }
    let(:vat_code) { 5 }
    let(:phone) { Faker::PhoneNumber.cell_phone }
    let(:email) { Faker::Internet.email }
    let(:receipt_item) { Yaka::ReceiptItem.new(description: name, amount: price, quantity: quantity, vat_code: vat_code) }

    context 'with phone' do
      subject { described_class.new(items: [receipt_item], phone: phone).to_json }
      it 'should make json' do
        expect(subject).to eq({items: [receipt_item], phone: phone}.to_json)
      end
    end
  end
end
