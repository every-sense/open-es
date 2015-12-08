module DataAbstraction::Unit
  class UserStatusValue < Generic
    STANDARD_UNIT = "iPhone"
    UNITS = [
             [ "iphone", "iPhone" ]
            ]
    @@unit_table = unit_table(UNITS)

    def initialize(value, unit = STANDARD_UNIT)
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
