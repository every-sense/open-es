module DataAbstraction::Unit
  class MagneticValue < Generic
    STANDARD_UNIT = "T"
    UNITS = [
             [ "tesla", "T" ],
             [ "milli_tesla", "mT" ],
             [ "micro_tesla", "uT", "microtesla" ],
             [ "nano_tesla", "nT", "nanotesla" ],
             [ "gauss", "Gauss" ]
            ]
    @@unit_table = unit_table(UNITS)

    def initialize(value, unit = STANDARD_UNIT)
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
      when "milli_tesla"
        MagneticValue.new(@value / 1000.0, STANDARD_UNIT)
      when "micro_tesla"
        MagneticValue.new(@value / 1000000.0, STANDARD_UNIT)
      when "nano_tesla"
        MagneticValue.new(@value / 1000000000.0, STANDARD_UNIT)
      when "gauss"
        MagneticValue.new(@value / 10000.0, STANDARD_UNIT)
      else
        self
      end
    end
    def to_requested(unit = STANDARD_UNIT)
      if ( unit != @unit )
        standard = self.to_standard
        case @@unit_table[unit]
        when "milli_tesla"
          MagneticValue.new(standard.value * 1000.0, unit)
        when "micro_tesla"
          MagneticValue.new(standard.value * 1000000.0, unit)
        when "nano_tesla"
          MagneticValue.new(standard.value * 1000000000.0, unit)
        when "gauss"
          MagneticValue.new(standard.value * 10000.0, unit)
        when "tesla"
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
