require 'rails_helper'

RSpec.describe ProductAccessory, type: :model do
  subject { create(:product_accessory) }

  let(:product_accessory) { subject }
  let(:accessory) { product_accessory.accessory }

  it { should belong_to(:custom_product) }
  it { should belong_to(:accessory) }

  it "should have accessory_price from Accessory sale_price" do
    expect(product_accessory.accessory_price).to eq(accessory.sale_price)
  end
end
