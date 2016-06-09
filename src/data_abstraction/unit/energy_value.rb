module DataAbstraction::Unit
  class EnergyValue < Generic
    STANDARD_UNIT = "J"
    UNITS = [
             [ "j",     "J" ],
             [ "kj",    "kJ", "KJ" ],
             [ "mj",    "MJ" ],
             [ "gj",    "GJ" ],
             [ "milli_j", "mJ" ],
             [ "micro_j", "uJ" ],
             [ "nano_j",  "nJ" ],
             [ "pico_j",  "pJ" ],

             [ "cal", "cal" ],
             [ "kcal", "kcal", "Cal" ],

             [ "pico_wh", "pwh", "pWh" ],
             [ "nano_wh", "nwh", "nWh" ],
             [ "micro_wh", "uwh", "uWh" ],
             [ "milli_wh", "mwh", "mWh" ],
             [ "wh", "wh", "Wh" ],
             [ "Kwh", "kwh", "KWh" ],
             [ "Mwh", "Mwh", "MWh" ],
             [ "Gwh", "Gwh", "GWh" ],

             [ "ev", "ev", "eV" ],
             [ "Kev", "kev", "Kev", "KeV" ],
             [ "Mev", "Mev", "MeV" ],
             [ "Gev", "Gev", "GeV" ],
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
      when "kj"
        EnergyValue.new(@value * 1000.0, STANDARD_UNIT)
      when "mj"
        EnergyValue.new(@value * 1000000.0, STANDARD_UNIT)
      when "gj"
        EnergyValue.new(@value * 1000000000.0, STANDARD_UNIT)
      when "milli_j"
        EnergyValue.new(@value / 1000.0, STANDARD_UNIT)
      when "micro_j"
        EnergyValue.new(@value / 1000000.0, STANDARD_UNIT)
      when "nano_j"
        EnergyValue.new(@value / 1000000000.0, STANDARD_UNIT)
      when "pico_j"
        EnergyValue.new(@value / 1000000000000.0, STANDARD_UNIT)

      when "cal"
        EnergyValue.new(@value * 4.184, STANDARD_UNIT)
      when "kcal"
        EnergyValue.new(@value * 1000.0 * 4.184, STANDARD_UNIT)

      when "wh"
        EnergyValue.new(@value * 3600.0, STANDARD_UNIT)
      when "Kwh"
        EnergyValue.new(@value * 3600.0 * 1000.0, STANDARD_UNIT)
      when "Mwh"
        EnergyValue.new(@value * 3600.0 * 1000000.0, STANDARD_UNIT)
      when "Gwh"
        EnergyValue.new(@value * 3600.0 * 1000000000.0, STANDARD_UNIT)
      when "milli_wh"
        EnergyValue.new(@value * 3600.0 / 1000.0, STANDARD_UNIT)
      when "micro_wh"
        EnergyValue.new(@value * 3600.0 / 1000000.0, STANDARD_UNIT)
      when "nano_wh"
        EnergyValue.new(@value * 3600.0 / 1000000000.0, STANDARD_UNIT)
      when "pico_wh"
        EnergyValue.new(@value * 3600.0 / 1000000000000.0, STANDARD_UNIT)

      when "ev"
        EnergyValue.new(@value * 0.1602e-18, STANDARD_UNIT)
      when "Kev"
        EnergyValue.new(@value * 1000.0 * 0.1602e-18, STANDARD_UNIT)
      when "Mev"
        EnergyValue.new(@value * 1000000.0 * 0.1602e-18, STANDARD_UNIT)
      when "Gev"
        EnergyValue.new(@value * 1000000000.0 * 0.1602e-18, STANDARD_UNIT)

      else
        self
      end
    end
    def to_requested(unit = STANDARD_UNIT)
      if ( unit != @unit )
        standard = self.to_standard
        case @@unit_table[unit]
        when "kj"
          EnergyValue.new(standard.value / 1000.0, unit)
        when "mj"
          EnergyValue.new(standard.value / 1000000.0, unit)
        when "gj"
          EnergyValue.new(standard.value / 1000000000.0, unit)
        when "milli_j"
          EnergyValue.new(standard.value * 1000.0, unit)
        when "micro_j"
          EnergyValue.new(standard.value * 1000000.0, unit)
        when "nano_j"
          EnergyValue.new(standard.value * 1000000000.0, unit)
        when "pico_j"
          EnergyValue.new(standard.value * 1000000000000.0, unit)
        when "j"
          standard

        when "cal"
          EnergyValue.new(standard.value / 4.184, unit)
        when "kcal"
          EnergyValue.new(standard.value / ( 4.184 * 1000.0 ), unit)

        when "wh"
          EnergyValue.new(standard.value * 3600.0, unit)
        when "Kwh"
          EnergyValue.new(standard.value * ( 3600.0 * 1000.0 ), unit)
        when "Mwh"
          EnergyValue.new(standard.value * ( 3600.0 * 1000000.0 ), unit)
        when "Gwh"
          EnergyValue.new(standard.value * ( 3600.0 * 1000000000.0 ), unit)
        when "milli_wh"
          EnergyValue.new(standard.value * ( 3600.0 / 1000.0 ), unit)
        when "micro_wh"
          EnergyValue.new(standard.value * ( 3600.0 / 1000000.0 ), unit)
        when "nano_wh"
          EnergyValue.new(standard.value * ( 3600.0 / 1000000000.0 ), unit)
        when "pico_wh"
          EnergyValue.new(standard.value * ( 3600.0 / 1000000000000.0 ), unit)

        when "ev"
          EnergyValue.new(standard.value / 0.1602e-18, unit)
        when "Kev"
          EnergyValue.new(standard.value / ( 1000.0 * 0.1602e-18 ), unit)
        when "Mev"
          EnergyValue.new(standard.value / ( 1000000.0 * 0.1602e-18 ), unit)
        when "Gev"
          EnergyValue.new(standard.value / ( 1000000000.0 * 0.1602e-18 ), unit)

        else
          nil
        end
      else
        self
      end
    end
  end
end
