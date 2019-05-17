# Generate StuffedAnimal and Accessory data from yml files
%w(StuffedAnimal Accessory).each do |klass_name|
  seed_file = Rails.root.join('db', 'seeds', "#{klass_name.underscore}.yml")
  config = YAML::load_file(seed_file)
  klass_name.constantize.create!(config)
end

# Generate AccessoryCompatibility data
accessory_compatibilities = {
  'Bear' => {
    'medium' => %w(Shoes T-Shirt),
    'All' => %w(Tiara Glasses)
  },
  'Elephant' => {
    'large' => %w(Shoes T-Shirt),
    'All' => %w(Tiara Glasses)
  },
  'Tiger' => {
    'small' => %w(Shoes T-Shirt),
    'All' => %w(Tiara Glasses)
  },
  'Gorilla' => {
    'medium' => %w(Shoes T-Shirt),
    'All' => %w(Tiara Glasses)
  }
}

accessory_compatibilities.each do |stuffed_animal_name, accessories_hash|
  stuffed_animal = StuffedAnimal.find_by(name: stuffed_animal_name)
  accessories_hash.each do |size, accessory_name_array|
    accessory_name_array.each do |accessory_name|
      accessory = Accessory.find_by(name: accessory_name, size: size)
      AccessoryCompatibility.create!(stuffed_animal: stuffed_animal, accessory: accessory) rescue binding.pry
    end
  end
end

# Generate Order data from CSV file
require 'csv'
header = ['date', 'time', 'bear', 'elephant', 'tiger', 'gorilla', 'small_shoes', 'small_tshirt',
  'medium_shoes', 'medium_tshirt', 'large_shoes', 'large_tshirt', 'tiara', 'glasses']

file = Rails.root.join('db', 'seeds', 'orders.csv')
# Use headers: false to remove bad header from `row`
CSV.foreach(file, headers: false) do |row|
  row_num = $.
  next unless row_num > 2 # Skip the first 2 rows: Contain headers data
  order = Order.new

  # Process Order's completed_at
  data = header.zip(row).to_h
  month, day, year = data['date'].squish.split('/')
  completed_at = [[year, month, day].join('-'), data['time'].squish].join(' ').to_datetime
  order.completed_at = completed_at

  # Generate CustomProduct data
  custom_product = order.custom_products.new

  # Find Stuffed Animal for the CustomProduct
  %w(bear elephant tiger gorilla).each do |stuffed_animal_name|
    next if custom_product.stuffed_animal_id.present?
    if data[stuffed_animal_name] == '1'
      stuffed_animal = StuffedAnimal.find_by(name: stuffed_animal_name.titleize)
      custom_product.stuffed_animal_id = stuffed_animal.id
    end
  end

  # Find Accessories attached to the CustomProduct
  accessories_name_and_size = %w(small_shoes small_tshirt medium_shoes medium_tshirt large_shoes 
                              large_tshirt tiara glasses)
  accessories_name_and_size.each do |name_and_size|
    value = data[name_and_size]
    next if value == '0'
    if name_and_size.include?('_')
      size, name = name_and_size.split('_')
      name = (name == 'shoes' ? 'Shoes' : 'T-Shirt')
    else # If not then it's either Tiara or Glasses
      size = 'All'
      name = name_and_size.titleize
    end
    accessory = Accessory.find_by(name: name, size: size)
    # Attach product_accessory into custom_product if found any
    custom_product.product_accessories.new(accessory: accessory) if accessory.persisted?
  end
  order.save
end
