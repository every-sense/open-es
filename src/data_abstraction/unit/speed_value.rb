module DataAbstraction::Unit
  class SpeedValue < Generic
    STANDARD_UNIT = "m/s"
    UNITS = [
             [ "mm/h", "mm/h" ],
             [ "m/s", "m/s" ],
             [ "cm/s", "cm/s" ],
             [ "Km/s", "Km/s" ]
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
      when "mm/h"
        SpeedValue.new(@value / ( 3600.0 * 1000.0 ), STANDARD_UNIT)
      when "cm/s"
        SpeedValue.new(@value / 100.0, STANDARD_UNIT)
      when "Km/s"
        SpeedValue.new(@value * 1000.0, STANDARD_UNIT)
      else
        self
      end
    end
    def to_requested(unit = STANDARD_UNIT)
      if ( unit != @unit )
        standard = self.to_standard
        case @@unit_table[unit]
        when "mm/h"
          SpeedValue.new(@value * ( 3600.0 * 1000.0 ), unit)
        when "cm/s"
          SpeedValue.new(standard.value * 100.0, unit)
        when "Km/s"
          SpeedValue.new(standard.value / 1000.0, unit)
        when "m/s"
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
