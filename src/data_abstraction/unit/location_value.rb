module DataAbstraction::Unit
  class LocationValue < Generic
    STANDARD_UNIT = "degree"
    ACCURACY_UNIT = "m"
    UNITS = [
             [ "degree",  "degree" ],
             [ "dms", "dms", "dd.mmss" ],
            ]
    @@unit_table = unit_table(UNITS)

    def initialize(values, unit = STANDARD_UNIT)
      if  ( @@unit_table[unit] )
        @values = values
        @unit = unit
      else
        raise RangeError, "invalid unit '#{unit}'"
      end
    end
    def self.accuracy_unit
      ACCURACY_UNIT
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
      when "dms"
        d = @value.to_i
        r = ( @value - d ) * 100.0
        m = r.to_i
        s = ( r - m ) * 100.0
        LocationValue(d + ( m + s / 60.0 ) / 60.0, STANDARD_UNIT)
      else
        self
      end
    end
    def to_requested(unit = STANDARD_UNIT)
      if ( unit != @unit )
        standard = self.to_standard
        case @@unit_table[unit]
        when "dms"
          d = standard.value.to_i
          r = ( standard.value - d ) * 60.0
          d2 = r.to_i
          d4 = ( r - d2 ) * 60.0
          LocationValue(d + ( d2 + d4 / 100.0 ) / 100.0, unit)
        else
          self
        end
      else
        self
      end
    end
  end
end
