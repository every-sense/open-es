module DataAbstraction::Unit
  class PressureValue < Generic
    STANDARD_UNIT = "Pa"
    UNITS = [
             [ "pascal",      "Pa" ],
             [ "hecto_pascal","hPa" ],
             [ "kilo_pascal", "KPa" ],
             [ "mega_pascal", "MPa" ],
             [ "giga_pascal", "GPa" ],
             [ "bar",         "bar" ],
             [ "mili_bar",    "mbar" ],
             [ "atomsphere",  "atm" ],
             [ "mmHg",        "mmHg" ],
             [ "torr",        "Tor" ]
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
    def standard_unit
      STANDARD_UNIT
    end
    def self.units
      UNITS
    end
    def to_standard
      case @@unit_table[@unit]
      when "hecto_pascal"
        PressureValue.new(@value * 100.0, STANDARD_UNIT)
      when "kilo_pascal"
        PressureValue.new(@value * 1000.0, STANDARD_UNIT)
      when "mega_pascal"
        PressureValue.new(@value * 1000000.0, STANDARD_UNIT)
      when "giga_pascal"
        PressureValue.new(@value * 1000000000.0, STANDARD_UNIT)
      when "bar"
        PressureValue.new(@value * 100000.0, STANDARD_UNIT)
      when "mili_bar"
        PressureValue.new(@value * 100.0, STANDARD_UNIT)
      when "atomsphere"
        PressureValue.new(@value * 101325.0, STANDARD_UNIT)
      when "mmHg", "torr"
        PressureValue.new(@value * 133.3224, STANDARD_UNIT)
      else
        self
      end
    end
    def to_requested(unit = STANDARD_UNIT)
      if ( unit != @unit )
        standard = self.to_standard
        case @@unit_table[unit]
        when "hecto_pascal"
          PressureValue.new(standard.value / 100.0, unit)
        when "kilo_pascal"
          PressureValue.new(standard.value / 1000.0, unit)
        when "mega_pascal"
          PressureValue.new(standard.value / 1000000.0, unit)
        when "giga_pascal"
          PressureValue.new(standard.value / 1000000000.0, unit)
        when "bar"
          PressureValue.new(standard.value / 100000.0, unit)
        when "mili_bar"
          PressureValue.new(standard.value / 100.0, unit)
        when "atomsphere"
          PressureValue.new(standard.value / 101325.0, unit)
        when "mmHg", "torr"
          PressureValue.new(standard.value / 133.3224, unit)
        when "pascal"
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
