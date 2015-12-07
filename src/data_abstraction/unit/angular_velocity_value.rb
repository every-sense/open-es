module DataAbstraction::Unit
  class AngularVelocityValue < Generic
    STANDARD_UNIT = "deg/s"
    UNITS = [
             [ "deg/s", "deg/s" ],
             [ "rad/s", "rad/s" ]
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
    def standard_unit
      STANDARD_UNIT
    end
    def self.units
      UNITS
    end
    def to_standard
      case @@unit_table[@unit]
      when "rad/s"
        AngularVelocityValue.new(@value * 180.0 / Math::PI , STANDARD_UNIT)
      else
        self
      end
    end
    def to_requested(unit = STANDARD_UNIT)
      if ( unit != @unit )
        standard = self.to_standard
        case @@unit_table[unit]
        when "rad/s"
          AngularVelocityValue.new(( standard.value * Math::PI ) / 180.0, unit)
        when STANDARD_UNIT
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
