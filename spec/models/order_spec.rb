require 'rails_helper'

RSpec.describe Order, type: :model do
  subject { create(:order) }

  it { should have_many(:custom_products) }
end
