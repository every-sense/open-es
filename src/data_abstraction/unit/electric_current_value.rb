module DataAbstraction::Unit
  class ElectricCurrentValue < Generic
    STANDARD_UNIT = "A"
    UNITS = [
             [ "ka", "KA", "kA" ],
             [ "a", "A" ],
             [ "milli_a", "mA" ],
             [ "micro_a", "uA", "micro A" ],
             [ "nano_a", "nA", "nano A" ],
             [ "pico_a", "pA", "pico A" ],
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
      when "ka"
        ElectricCurrentValue.new(@value * 1000.0, STANDARD_UNIT)
      when "milli_a"
        ElectricCurrentValue.new(@value / 1000.0, STANDARD_UNIT)
      when "micro_a"
        ElectricCurrentValue.new(@value / 1000000.0, STANDARD_UNIT)
      when "nano_a"
        ElectricCurrentValue.new(@value / 1000000000.0, STANDARD_UNIT)
      when "pico_a"
        ElectricCurrentValue.new(@value / 1000000000000.0, STANDARD_UNIT)
      else
        self
      end
    end
    def to_requested(unit = STANDARD_UNIT)
      if ( unit != @unit )
        standard = self.to_standard
        case @@unit_table[unit]
        when "ka"
          ElectricCurrentValue.new(standard.value / 1000.0, unit)
        when "milli_a"
          ElectricCurrentValue.new(standard.value * 1000.0, unit)
        when "micro_a"
          ElectricCurrentValue.new(standard.value * 1000000.0, unit)
        when "nano_a"
          ElectricCurrentValue.new(standard.value * 1000000000.0, unit)
        when "pico_a"
          ElectricCurrentValue.new(standard.value * 1000000000000.0, unit)
        when "a"
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
