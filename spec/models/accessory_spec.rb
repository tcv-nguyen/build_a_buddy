require 'rails_helper'

RSpec.describe Accessory, type: :model do
  subject { create(:accessory) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:size) }
  it { should validate_uniqueness_of(:size).scoped_to(:name) }
end
