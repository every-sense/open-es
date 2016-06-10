module DataAbstraction::Unit
  class UnknownValue < Generic
    STANDARD_UNIT = nil
    UNITS = [
             [ "", "", nil ],
            ]
    @@unit_table = unit_table(UNITS)

    def initialize(value, unit = STANDARD_UNIT)
      @value = value
      @unit = unit if unit
    end
    def self.standard_unit
      nil
    end
    def standard_unit
      nil
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
