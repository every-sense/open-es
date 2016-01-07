module DataAbstraction::Unit
  class AccelerationValue < Generic
    STANDARD_UNIT = "m/s^2"
    UNITS = [
             [ "m/s^2",  "m/s^2" ],
             [ "cm/s^2", "cm/s^2" ],
             [ "mm/s^2", "mm/s^2" ],
             [ "gal",    "Gal" ],
             [ "g",      "G" ],
             [ "mg",     "mG" ]
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
      when "cm/s^2", "gal"
        AccelerationValue.new(@value / 100.0, STANDARD_UNIT)
      when "mm/s^2"
        AccelerationValue.new(@value / 1000.0, STANDARD_UNIT)
      when "g"
        AccelerationValue.new(@value * 9.80665, STANDARD_UNIT)
      when "mg"
        AccelerationValue.new(@value * 9.80665 / 1000.0, STANDARD_UNIT)
      else
        self
      end
    end
    def to_requested(unit = STANDARD_UNIT)
      if ( unit != @unit )
        standard = self.to_standard
        case @@unit_table[unit]
        when "cm/s^2", "gal"
          AccelerationValue.new(standard.value * 100.0, unit)
        when "mm/s^2"
          AccelerationValue.new(standard.value * 1000.0, unit)
        when "g"
          AccelerationValue.new(standard.value / 9.80665, unit)
        when "mg"
          AccelerationValue.new(standard.value / 9.80665 * 1000, unit)
        when "m/s^2"
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
