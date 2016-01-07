module DataAbstraction::Unit
  class AngularAccelerationValue < Generic
    STANDARD_UNIT = "deg/s^2"
    UNITS = [
             [ "deg/s^2", "deg/s^2" ],
             [ "rad/s^2", "rad/s^2" ]
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
      when "rad/s^2"
        AngularAccelerationValue.new(@value * 180.0 / Math::PI , STANDARD_UNIT)
      else
        self
      end
    end
    def to_requested(unit = STANDARD_UNIT)
      if ( unit != @unit )
        standard = self.to_standard
        case @@unit_table[unit]
        when "rad/s^2"
          AngularAccelerationValue.new(( standard.value * Math::PI ) / 180.0, unit)
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
