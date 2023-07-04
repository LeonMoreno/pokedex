require 'rails_helper'

RSpec.describe Pokemon, type: :model do
  describe "Validations" do
    it "validate presence required fields" do
      should validate_presence_of(:name)
      should validate_presence_of(:type_1)
      should validate_presence_of(:total)
      should validate_presence_of(:attack)
      should validate_presence_of(:defense)
    end
  end
end
