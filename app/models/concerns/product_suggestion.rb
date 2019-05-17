class ProductSuggestion
  def initialize
  end

  def other_also_bought(products_set_ids = [])
    # Generate a list in case User already picked the suggest product, so we can suggest another
    suggestion_ids = []
    CustomProduct.joins(:order).order('orders.completed_at').find_in_batches(batch_size: 100) do |batch|
      stuffed_animal_ids = batch.pluck(:stuffed_animal_id)
      # Loop through stuffed_animal_ids to find the ids that match with products_set_ids
      (0..stuffed_animal_ids.size).each do |start|
        # Get the sliced_ids from stuffed_animal_ids with same size as products_set_ids
        sliced_ids = stuffed_animal_ids.slice(start, products_set_ids.size)

        # If we have a match, we'll get the next product_id as suggestion
        if sliced_ids == products_set_ids
          suggestion_index = start + products_set_ids.size
          # Ensure the suggestion_index is not nil (End of array)
          suggestion_ids << stuffed_animal_ids[suggestion_index] unless stuffed_animal_ids[suggestion_index].blank?
        end
      end
    end
    suggest_id = suggestion_ids.uniq.first
    # In case suggest_id is nil
    StuffedAnimal.find_by(id: suggest_id)
  end

  def best_products_for_price(max_price)
    suggestion_products = []
    # Loop through StuffedAnimal to get sale_price < max_price
    StuffedAnimal.all.each do |stuffed_animal|
      next if stuffed_animal.sale_price > max_price
      custom_product = CustomProduct.new(stuffed_animal: stuffed_animal)

      # Recursive through AccessoryCompatibility for eligible total sale_price < max_price
      accessories = stuffed_animal.accessories.to_a
      accessories.each do |accessory|
        possible_accessories = accessories - [accessory]
        custom_product.add_accessory(accessory, possible_accessories, max_price)
      end
      unless suggestion_products_already_has_product(suggestion_products, custom_product)
        suggestion_products << custom_product
      end
    end
    return nil if suggestion_products.blank?
    
    # If there are multiple products with same profit, sort by least sale_price for advertising
    best_products = suggestion_products.sort_by { |sp| [sp.profit, -sp.sale_price] }.reverse.slice(0, 3)
  end

  private
    def suggestion_products_already_has_product(suggestion_products, product)
      # Compare each product stuffed animal and accessories to ensure no duplicate
      suggestion_products.any? do |suggest_product|
        suggest_product.same_as?(product)
      end
    end
end