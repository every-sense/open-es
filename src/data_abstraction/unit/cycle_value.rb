module DataAbstraction::Unit
  class CycleValue < Generic
    STANDARD_UNIT = "Hz"
    UNITS = [
             [ "hz",  "Hz" ],
             [ "khz", "KHz", "kHz" ],
             [ "mhz", "MHz" ],
             [ "ghz", "GHz" ],
             [ "s",   "s" ],
             [ "ms",  "ms" ],
             [ "us",  "us" ],
             [ "ns",  "ns" ],
             [ "ps",  "ps" ],
             [ "bpm", "bpm" ],
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
      when "bpm"
        CycleValue.new(@value / 60.0, STANDARD_UNIT)
      when "khz"
        CycleValue.new(@value * 1000.0, STANDARD_UNIT)
      when "mhz"
        CycleValue.new(@value * 1000000.0, STANDARD_UNIT)
      when "ghz"
        CycleValue.new(@value * 1000000000.0, STANDARD_UNIT)
      when "s"
        CycleValue.new(1.0 / @value, STANDARD_UNIT)
      when "ms"
        CycleValue.new(1000.0 / @value , STANDARD_UNIT)
      when "us"
        CycleValue.new(1000000.0 / @value, STANDARD_UNIT)
      when "ns"
        CycleValue.new(1000000000.0 / @value, STANDARD_UNIT)
      when "ps"
        CycleValue.new(1000000000000.0 / @value, STANDARD_UNIT)
      else
        self
      end
    end
    def to_requested(unit = STANDARD_UNIT)
      if ( unit != @unit )
        standard = self.to_standard
        case @@unit_table[unit]
        when "bpm"
          CycleValue.new(standard.value * 60.0, unit)
        when "khz"
          CycleValue.new(standard.value / 1000.0, unit)
        when "mhz"
          CycleValue.new(standard.value / 1000000.0, unit)
        when "ghz"
          CycleValue.new(standard.value / 1000000000.0, unit)
        when "s"
          CycleValue.new(1.0 / standard.value, unit)
        when "ms"
          CycleValue.new(1000.0 / standard.value, unit)
        when "us"
          CycleValue.new(1000000.0 / standard.value, unit)
        when "ns"
          CycleValue.new(1000000000.0 / standard.value, unit)
        when "ps"
          CycleValue.new(1000000000000.0 / standard.value, unit)
        when "hz"
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
