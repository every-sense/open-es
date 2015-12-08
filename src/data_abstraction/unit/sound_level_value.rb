include Math
module DataAbstraction::Unit
  class SoundLevelValue < Generic
    STANDARD_UNIT = "dB"
    UNITS = [
             [ "db", "dB" ],
             [ "pascal", "Pa" ]
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
    def self.units # [ symbol, name ]
      UNITS
    end
    def to_standard
      case @@unit_table[@unit]
      when "pascal"
        SoundLevelValue.new( 20.0 * log10( @value / ( 20.0 / 1000000.0 ) ), STANDARD_UNIT )
      else
        self
      end
    end
    def to_requested(unit = STANDARD_UNIT)
      if ( unit != @unit )
        standard = self.to_standard
        case @@unit_table[unit]
        when "pascal"
          SoundLevelValue.new(( 20.0 / 1000000.0 ) * 10.0 ** ( standard.value / 20.0 ), unit)
        when "db"
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
