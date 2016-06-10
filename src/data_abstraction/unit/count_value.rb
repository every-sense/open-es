module DataAbstraction::Unit
  class CountValue < Generic
    STANDARD_UNIT = "Count"
    UNITS = [
             [ "count", "Counts", "count", "counts" ],
             [ "person", "Persons", "persons", "person" ],
             [ "floor", "Floors", "floors", "floor" ],
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
      self
    end
    def to_requested(unit = STANDARD_UNIT)
      if ( unit != @unit )
        standard = self.to_standard
      else
        self
      end
    end
  end
end
