module DataAbstraction::Unit
  class SymbolicValue < Generic
    STANDARD_UNIT = nil
    UNITS = [
             [ "", "" ]
            ]
    @@unit_table = unit_table(UNITS)

    def initialize(value, unit = STANDARD_UNIT)
      @value = value
      @unit = unit
    end
    def self.units
      UNITS
    end
    def standard_unit
      STANDARD_UNIT
    end
    def to_standard
      self
    end
    def to_requested(unit = STANDARD_UNIT)
      self
    end
  end
end
