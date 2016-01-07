module DataAbstraction::Unit
  class PowerValue < Generic
    STANDARD_UNIT = "W"
    UNITS = [
             [ "w",     "W" ],
             [ "kw",    "kW", "KW" ],
             [ "mw",    "MW" ],
             [ "gw",    "GW" ],
             [ "milli_w", "mW" ],
             [ "micro_w", "uW" ],
             [ "nano_w",  "nW" ],
             [ "pico_w",  "pW" ]
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
      when "kw"
        PowerValue.new(@value * 1000.0, STANDARD_UNIT)
      when "mw"
        PowerValue.new(@value * 1000000.0, STANDARD_UNIT)
      when "gw"
        PowerValue.new(@value * 1000000000.0, STANDARD_UNIT)
      when "milli_w"
        PowerValue.new(@value / 1000.0, STANDARD_UNIT)
      when "micro_w"
        PowerValue.new(@value / 1000000.0, STANDARD_UNIT)
      when "nano_w"
        PowerValue.new(@value / 1000000000.0, STANDARD_UNIT)
      when "pico_w"
        PowerValue.new(@value / 1000000000000.0, STANDARD_UNIT)
      else
        self
      end
    end
    def to_requested(unit = STANDARD_UNIT)
      if ( unit != @unit )
        standard = self.to_standard
        case @@unit_table[unit]
        when "kw"
          PowerValue.new(standard.value / 1000.0, unit)
        when "mw"
          PowerValue.new(standard.value / 1000000.0, unit)
        when "gw"
          PowerValue.new(standard.value / 1000000000.0, unit)
        when "milli_w"
          PowerValue.new(standard.value * 1000.0, unit)
        when "micro_w"
          PowerValue.new(standard.value * 1000000.0, unit)
        when "nano_w"
          PowerValue.new(standard.value * 1000000000.0, unit)
        when "pico_w"
          PowerValue.new(standard.value * 1000000000000.0, unit)
        when "w"
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
