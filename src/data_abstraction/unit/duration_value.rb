module DataAbstraction::Unit
  class DurationValue < Generic
    STANDARD_UNIT = "second"
    UNITS = [
             [ "milli_second",  "milli_second", "milli_seconds", "ms" ],
             [ "second",  "second", "seconds", "s" ],
             [ "minute",  "minute", "minites", "m" ],
             [ "hour",  "hour", "hours", "h" ],
             [ "day",  "day", "days", "d" ],
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
      when "milli_second"
        DurationValue.new(@value / 1000.0, STANDARD_UNIT)
      when "minute"
        DurationValue.new(@value * 60.0, STANDARD_UNIT)
      when "hour"
        DurationValue.new(@value * 3600.0, STANDARD_UNIT)
      when "day"
        DurationValue.new(@value * 3600.0 * 24.0, STANDARD_UNIT)
      else
        self
      end
    end
    def to_requested(unit = STANDARD_UNIT)
      if ( unit != @unit )
        standard = self.to_standard
        case @@unit_table[unit]
        when "milli_second"
          DurationValue.new(@value * 1000.0, unit)
        when "minute"
          DurationValue.new(@value / 60.0, unit)
        when "hour"
          DurationValue.new(@value / 3600.0, unit)
        when "day"
          DurationValue.new(@value / ( 3600.0 * 24.0 ), unit)
        when "second"
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
