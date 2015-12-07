module DataAbstraction::Unit
  class TemperatureValue < Generic
    STANDARD_UNIT = "degree Celsius"
    UNITS = [
             [ "degree celsius", "degree Celsius", "Celsius" ],
             [ "degree fahrenheit", "degree Fahrenheit", "Fahrenheit" ],
             [ "k", "K", "Kelbin" ]
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
      when "degree fahrenheit"
        TemperatureValue.new( ( @value - 32.0 ) * 5.0 / 9.0 , STANDARD_UNIT)
      when "k"
        TemperatureValue.new( @value + 273.15 , STANDARD_UNIT)
      else
        self
      end
    end
    def to_requested(unit = STANDARD_UNIT)
      if ( unit != @unit )
        standard = self.to_standard
        case @@unit_table[unit]
        when "degree fahrenheit"
          TemperatureValue.new(( standard.value * 9.0 / 5.0 ) + 32, unit)
        when "k"
          TemperatureValue.new(standard.value + 273.15, unit)
        when "degree celsius"
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
