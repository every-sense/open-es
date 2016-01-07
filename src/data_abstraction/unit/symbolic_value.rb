module DataAbstraction::Unit
  class SymbolicValue < Generic
    STANDARD_UNIT = nil
    UNITS = [
             [ "", "" ]
            ]
    @@unit_table = unit_table(UNITS)

    def initialize(value, unit = STANDARD_UNIT)
      unit = STANDARD_UNIT if ( !unit )
      @value = value
      @unit = unit
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
      self
    end
  end
end
