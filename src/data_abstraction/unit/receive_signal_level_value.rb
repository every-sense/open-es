# -*- coding: utf-8 -*-
include Math
module DataAbstraction::Unit
  class ReceiveSignalLevelValue < Generic
    STANDARD_UNIT = "dBm"
    UNITS = [
             [ "dbm", "dBm", "dbm" ],
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
    def self.units # [ symbol, name ]
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
