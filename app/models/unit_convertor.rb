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
        liter: {
            cup: 4.226775,
            liter: 1,
            pint: 2.11338
        },
        gram: {
            gram: 1,
            kilogram: 1000,
        }
    }

    def conversion_factor(from:, to:)
        dimension = common_dimension(from, to)
        if !dimension.nil?
            CONVERSION_FACTORS[dimension][to] / CONVERSION_FACTORS[dimension][from]
        else
            raise(DimensionalMismatchError, "Can't convert from #{from} to #{to}!")
        end
    end

    def common_dimension(from, to)
        CONVERSION_FACTORS.keys.find do |canonical_unit|
            CONVERSION_FACTORS[canonical_unit].keys.include?(from) &&
                CONVERSION_FACTORS[canonical_unit].keys.include?(to)
        end
    end

end