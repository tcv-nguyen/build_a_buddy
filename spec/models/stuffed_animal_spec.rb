require 'rails_helper'

RSpec.describe StuffedAnimal, type: :model do
  subject { create(:stuffed_animal) }
  
  it { should validate_presence_of(:name) }
end
