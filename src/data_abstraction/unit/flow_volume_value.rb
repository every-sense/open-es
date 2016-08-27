module DataAbstraction::Unit
  class FlowVolumeValue < Generic
    STANDARD_UNIT = "L/s"
    UNITS = [
             [ "milli_meter_3", "mm^3/s", "uL/s", "ul/s" ],
             [ "centi_meter_3", "cm^3/s", "mL/s", "ml/s" ],
             [ "L", "L/s", "l/s" ],
             [ "meter_3", "m^3/s", "kL/s", "KL/s", "kl/s" ],
             [ "kilo_meter_3", "Km^3/s", "km^3/s", "KM^3/s" ]
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
      when "milli_meter_3"
        FlowVolumeValue.new(@value * 0.000001, STANDARD_UNIT)
      when "centi_meter_3"
        FlowVolumeValue.new(@value * 0.001, STANDARD_UNIT)
      when "meter_3"
        FlowVolumeValue.new(@value * 1000.0, STANDARD_UNIT)
      when "kilo_meter_3"
        FlowVolumeValue.new(@value * 1000000000000.0, STANDARD_UNIT)
      else
        self
      end
    end
    def to_requested(unit = STANDARD_UNIT)
      if ( unit != @unit )
        standard = self.to_standard
        case @@unit_table[unit]
        when "milli_meter_3"
          FlowVolumeValue.new(standard.value / 0.000001, unit)
        when "centi_meter_3"
          FlowVolumeValue.new(standard.value / 0.001, unit)
        when "L"
          FlowVolumeValue.new(standard.value, unit)
        when "meter_3"
          FlowVolumeValue.new(standard.value / 1000.0, unit)
        when "kilo_meter_3"
          FlowVolumeValue.new(standard.value / 1000000000000.0, unit)
        else
          nil
        end
      else
        self
      end
    end
  end
end
