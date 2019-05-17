class RelatedPurchased
  def initialize(products_set_ids = [])
    @products_set_ids = products_set_ids
  end

  def other_also_bought
    # Generate a list in case User already picked the suggest product, so we can suggest another
    suggestion_ids = []
    CustomProduct.joins(:order).order('orders.completed_at').find_in_batches(batch_size: 100) do |batch|
      stuffed_animal_ids = batch.pluck(:stuffed_animal_id)
      # Loop through stuffed_animal_ids to find the ids that match with @products_set_ids
      (0..stuffed_animal_ids.size).each do |start|
        # Get the sliced_ids from stuffed_animal_ids with same size as @products_set_ids
        sliced_ids = stuffed_animal_ids.slice(start, @products_set_ids.size)
        # If we have a match, we'll get the next product_id as suggestion
        if sliced_ids == @products_set_ids
          suggestion_index = start + @products_set_ids.size
          # Ensure the suggestion_index is not nil (End of array)
          suggestion_ids << stuffed_animal_ids[suggestion_index] unless stuffed_animal_ids[suggestion_index].blank?
        end
      end
    end
    suggest_id = suggestion_ids.uniq.first
    # In case suggest_id is nil
    StuffedAnimal.find_by(id: suggest_id)
  end
end