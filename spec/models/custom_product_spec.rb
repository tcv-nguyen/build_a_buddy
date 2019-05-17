require 'rails_helper'

RSpec.describe CustomProduct, type: :model do
  subject { create(:custom_product) }

  it { should belong_to(:order) }
end
