require 'rails_helper'

RSpec.describe ProductSuggestion, type: :model do
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
      product_suggestion = ProductSuggestion.new

      expect(product_suggestion.other_also_bought(product_ids)).to eq(suggest_product)
    end

    it "should suggest none if the product set match end of orders set" do
      products_set = %w(Gorilla Gorilla Bear Tiger Gorilla Elephant)
      product_ids = products_set.map { |name| StuffedAnimal.find_by(name: name).id }
      product_suggestion = ProductSuggestion.new

      expect(product_suggestion.other_also_bought(product_ids)).to be_nil
    end
  end

  describe "#best_products_for_price" do
    before do
      @bear = create(:stuffed_animal, name: 'Bear', cost: 1, sale_price: 10)
      @lion = create(:stuffed_animal, name: 'Lion', cost: 2, sale_price: 12)
      @tiger = create(:stuffed_animal, name: 'Tiger', cost: 3, sale_price: 14)
      @elephant = create(:stuffed_animal, name: 'Elephant', cost: 4, sale_price: 16)
      @shoes = create(:accessory, name: 'Shoes', cost: 1, sale_price: 5)
      @shirt = create(:accessory, name: 'Shirt', cost: 2, sale_price: 7)
      @tiara = create(:accessory, name: 'Tiara', cost: 3, sale_price: 9)
      create(:accessory_compatibility, stuffed_animal: @bear, accessory: @shoes)
      create(:accessory_compatibility, stuffed_animal: @bear, accessory: @tiara)
      create(:accessory_compatibility, stuffed_animal: @lion, accessory: @shoes)
      create(:accessory_compatibility, stuffed_animal: @lion, accessory: @shirt)
      create(:accessory_compatibility, stuffed_animal: @tiger, accessory: @shirt)
      create(:accessory_compatibility, stuffed_animal: @tiger, accessory: @tiara)
      create(:accessory_compatibility, stuffed_animal: @elephant, accessory: @shoes)
      create(:accessory_compatibility, stuffed_animal: @elephant, accessory: @shirt)
      create(:accessory_compatibility, stuffed_animal: @elephant, accessory: @tiara)
    end

    it "should suggest the best 3 profit products" do
      product_suggestion = ProductSuggestion.new
      suggested_products = product_suggestion.best_products_for_price(14)
      best_product = suggested_products.first

      expect(suggested_products.size).to eq(3)
      expect(best_product.stuffed_animal).to eq(@tiger)
      expect(suggested_products.map(&:stuffed_animal).map(&:name)).to contain_exactly('Bear', 'Lion', 'Tiger')
    end

    it "should suggest the best 3 profit products with accessory" do
      product_suggestion = ProductSuggestion.new
      suggested_products = product_suggestion.best_products_for_price(19)
      first_product, second_product, third_product = suggested_products

      expect(suggested_products.size).to eq(3)
      expect(first_product.stuffed_animal).to eq(@lion)
      expect(first_product.product_accessories.map(&:accessory).map(&:name)).to contain_exactly('Shoes')
      expect(first_product.sale_price).to eq(17)
      expect(first_product.profit).to eq(14)

      expect(second_product.stuffed_animal).to eq(@bear)
      expect(second_product.product_accessories.map(&:accessory).map(&:name)).to contain_exactly('Shoes')
      expect(second_product.sale_price).to eq(15)
      expect(second_product.profit).to eq(13)

      expect(third_product.stuffed_animal).to eq(@elephant)
      expect(third_product.product_accessories).to be_blank
      expect(third_product.sale_price).to eq(16)
      expect(third_product.profit).to eq(12)
    end

    it "should suggest the best products with combo accessories" do
      product_suggestion = ProductSuggestion.new
      suggested_products = product_suggestion.best_products_for_price(40)
      first_product, second_product, third_product = suggested_products

      expect(suggested_products.size).to eq(3)
      expect(first_product.stuffed_animal).to eq(@elephant)
      expect(first_product.product_accessories.map(&:accessory).map(&:name)).to contain_exactly('Shoes', 'Shirt', 'Tiara')
      expect(first_product.sale_price).to eq(37)
      expect(first_product.profit).to eq(27)
      expect(second_product.stuffed_animal).to eq(@tiger)
      expect(second_product.product_accessories.map(&:accessory).map(&:name)).to contain_exactly('Shirt', 'Tiara')
      expect(second_product.sale_price).to eq(30)
      expect(second_product.profit).to eq(22)
      expect(third_product.stuffed_animal).to eq(@lion)
      expect(third_product.product_accessories.map(&:accessory).map(&:name)).to contain_exactly('Shoes', 'Shirt')
      expect(third_product.sale_price).to eq(24)
      expect(third_product.profit).to eq(19)
    end
  end
end
