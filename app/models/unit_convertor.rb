DimensionalMismatchError = Class.new(StandardError)

Quantity = Struct.new(:amount, :unit)

class UnitConvertor
    def initialize(initial_quantity, target_unit)
        @initial_quantity = initial_quantity
        @target_unit = target_unit
    end

    def convert
        Quantity.new(
        @initial_quantity.amount * conversion_factor(from: @initial_quantity.unit, to: @target_unit),
        @target_unit)
    end

    private

    CONVERSION_FACTORS = {
        cup: {
            liter: 0.236588
        }
    }

    def conversion_factor(from:, to:)
        CONVERSION_FACTORS[from][to] ||
        raise(DimensionalMismatchError, "Can't convert from #{from} to #{to}!")
    end
end