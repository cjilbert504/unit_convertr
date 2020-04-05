require 'rails_helper'

# RSpec.describe UnitConvertor, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

describe UnitConvertor do 

  describe "#convert" do

    it "translates between objects of the same dimension" do
      cups = Quantity.new(2, :cup)
      convertor = UnitConvertor.new(cups, :liter)
      
      result = convertor.convert
      
      expect(result.amount).to be_within(0.001).of(0.473)
      expect(result.unit).to eq(:liter)
    end
    
    it "raises an error if the two quantities are of differing dimensions" do 
      cups = Quantity.new(2, :cup)
      convertor = UnitConvertor.new(cups, :gram)

      expect { convertor.convert }.to raise_error(DimensionalMismatchError)
    end
  end

end