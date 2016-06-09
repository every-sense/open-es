module DataAbstraction::Unit
  class DimensionValue < Generic
    STANDARD_UNIT = "m"
    UNITS = [
             [ "inch", "in", "inch" ],
             [ "feet", "ft", "feet" ],
             [ "yard", "yd", "yard" ],
             [ "mile", "mile" ],
             [ "milli_meter", "mm" ],
             [ "centi_meter", "cm" ],
             [ "meter", "m" ],
             [ "kilo_meter", "Km", "km", "KM" ]
            ]
    @@unit_table = unit_table(UNITS)

    def initialize(value, unit = STANDARD_UNIT)
      unit = STANDARD_UNIT if ( !unit )
      if  ( @@unit_table[unit] )
        @value = value
        @unit = unit
      else
        raise RangeError, "invalid unit '#{unit}'"
      end
    end
    def self.standard_unit
      STANDARD_UNIT
    end
    def standard_unit
      STANDARD_UNIT
    end
    def self.units
      UNITS
    end
    def to_standard
      case @@unit_table[@unit]
      when "inch"
        DimensionValue.new(@value * 0.0254, STANDARD_UNIT)
      when "feet"
        DimensionValue.new(@value * 0.3048, STANDARD_UNIT)
      when "yard"
        DimensionValue.new(@value * 0.9144, STANDARD_UNIT)
      when "mile"
        DimensionValue.new(@value * 1609.344, STANDARD_UNIT)
      when "milli_meter"
        DimensionValue.new(@value / 1000.0, STANDARD_UNIT)
      when "centi_meter"
        DimensionValue.new(@value / 100.0, STANDARD_UNIT)
      when "kilo_meter"
        DimensionValue.new(@value * 1000.0, STANDARD_UNIT)
      else
        self
      end
    end
    def to_requested(unit = STANDARD_UNIT)
      if ( unit != @unit )
        standard = self.to_standard
        case @@unit_table[unit]
        when "inch"
          DimensionValue.new(standard.value / 0.0254, unit)
        when "feet"
          DimensionValue.new(standard.value / 0.3048, unit)
        when "yard"
          DimensionValue.new(standard.value / 0.9144, unit)
        when "mile"
          DimensionValue.new(standard.value / 1609.344, unit)
        when "milli_meter"
          DimensionValue.new(standard.value * 1000.0, unit)
        when "centi_meter"
          DimensionValue.new(standard.value * 100.0, unit)
        when "kilo_meter"
          DimensionValue.new(standard.value / 1000.0, unit)
        when "meter"
          standard
        else
          nil
        end
      else
        self
      end
    end
  end
end
