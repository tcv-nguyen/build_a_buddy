require 'rails_helper'

RSpec.describe RelatedPurchased, type: :model do
  describe "#other_also_bought" do
    before do
      %w(Bear Elephant Tiger Gorilla).each do |name|
        stuffed_animal = create(:stuffed_animal, name: name)
      end
      orders_set = %w(Bear Elephant Bear Tiger Elephant Gorilla Gorilla Bear Tiger Gorilla Elephant)
      orders_set.each do |name|
        stuffed_animal = StuffedAnimal.find_by(name: name)
        create(:custom_product, stuffed_animal: stuffed_animal)
      end
    end

    it "should suggest new product from a give set of product ids" do
      products_set = %w(Gorilla Gorilla Bear Tiger Gorilla)
      product_ids = products_set.map { |name| StuffedAnimal.find_by(name: name).id }
      suggest_product = StuffedAnimal.find_by(name: 'Elephant')
      related_purchased = RelatedPurchased.new(product_ids)

      expect(related_purchased.other_also_bought).to eq(suggest_product)
    end

    it "should suggest none if the product set match end of orders set" do
      products_set = %w(Gorilla Gorilla Bear Tiger Gorilla Elephant)
      product_ids = products_set.map { |name| StuffedAnimal.find_by(name: name).id }
      related_purchased = RelatedPurchased.new(product_ids)

      expect(related_purchased.other_also_bought).to be_nil
    end
  end
end
