require 'rails_helper'

RSpec.describe StuffedAnimal, type: :model do
  subject { create(:stuffed_animal) }
  
  it { should have_many(:accessory_compatibilities) }
  it { should have_many(:accessories) }
  it { should have_many(:custom_products) }
  it { should validate_presence_of(:name) }
end
