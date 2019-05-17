require 'rails_helper'

RSpec.describe AccessoryCompatibility, type: :model do
  subject { create(:accessory_compatibility) }

  it { should belong_to :stuffed_animal }
  it { should belong_to :accessory }
  it { should validate_uniqueness_of(:stuffed_animal_id).scoped_to(:accessory_id) }
end
