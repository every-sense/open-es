module DataAbstraction::Unit
  class FigureValue < Generic
    STANDARD_UNIT = ""
    UNITS = [
             [ "", "" ],
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
      self
    end
    def to_requested(unit = STANDARD_UNIT)
      standard = self.to_standard
    end
  end
end
