module DataAbstraction::Unit
  class DirectionValue < Generic
    STANDARD_UNIT = "degree"
    UNITS = [
             [ "degree", "degree" ],
             [ "radian", "radian" ]
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
      when "radian"
        DirectionValue.new(@value * Math::PI / 180.0, STANDARD_UNIT)
      else
        self
      end
    end
    def to_requested(unit = STANDARD_UNIT)
      if ( unit != @unit )
        standard = self.to_standard
        case @@unit_table[unit]
        when "radian"
          DirectionValue.new(@value / 180.0 * Math::PI, unit)
        when "degree"
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
