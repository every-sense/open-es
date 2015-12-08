module DataAbstraction::Unit
  class LocationValue < Generic
    STANDARD_UNIT = "degree"
    ACCURACY_UNIT = "m"
    UNITS = [
             [ "degree",  "degree" ],
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
  end
end
