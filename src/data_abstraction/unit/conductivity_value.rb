module DataAbstraction::Unit
  class ConductivityValue < Generic
    STANDARD_UNIT = "S/m"
    UNITS = [
             [ "S/m",   "S/m" ],
             [ "S/cm",  "S/cm" ],
             [ "mS/cm", "mS/cm" ],
             [ "uS/cm", "uS/cm" ]
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
      case @@unit_table[@unit]
      when "S/cm"
        ConductivityValue.new(@value / 100.0, STANDARD_UNIT)
      when "mS/cm"
        ConductivityValue.new(@value / 1000.0 / 100.0, STANDARD_UNIT)
      when "uS/cm"
        ConductivityValue.new(@value / 1000000.0 / 100.0, STANDARD_UNIT)
      else
        self
      end
    end
    def to_requested(unit = STANDARD_UNIT)
      if ( unit != @unit )
        standard = self.to_standard
        case @@unit_table[unit]
        when "S/cm"
          ConductivityValue.new(standard.value * 100.0, unit)
        when "mS/cm"
          ConductivityValue.new(standard.value * 100.0 * 1000.0, unit)
        when "uS/cm"
          ConductivityValue.new(standard.value * 100.0 * 1000000.0, unit)
        when "S/m"
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
