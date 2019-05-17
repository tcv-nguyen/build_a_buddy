require 'rails_helper'

RSpec.describe CustomProduct, type: :model do
  subject { create(:custom_product) }

  let(:custom_product) { subject }
  let(:stuffed_animal) { custom_product.stuffed_animal }

  it { should belong_to(:order) }
  it { should belong_to(:stuffed_animal) }

  it "should have stuffed_animal_price from StuffedAnimal sale_price" do
    expect(custom_product.stuffed_animal_price).to eq(stuffed_animal.sale_price)
  end
end
