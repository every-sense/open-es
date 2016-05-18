module DataAbstraction::Unit
  class SimpleString < Generic
    STANDARD_UNIT = ""
    UNITS = [
             [ "", "", nil ],
            ]
    @@unit_table = unit_table(UNITS)

    def initialize(value, unit = STANDARD_UNIT)
      @value = value
    end
    def self.standard_unit
      nil
    end
    def standard_unit
      nil
    end
    def self.units
      nil
    end
    def to_standard
      self
    end
    def to_requested(unit = STANDARD_UNIT)
      standard = self.to_standard
    end
  end
end
